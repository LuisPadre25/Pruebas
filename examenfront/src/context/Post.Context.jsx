import {createContext, useState, useEffect} from 'react';
import {
    getPosts,
    createPost,
    updatePost as apiUpdatePost,
    deletePost as apiDeletePost,
} from '../api/posts';
import {message, Modal} from 'antd';

export const PostContext = createContext();

const PostContextProvider = ({children}) => {
    const [posts, setPosts] = useState([]);
    const [loading, setLoading] = useState(false);

    const fetchPosts = async () => {
        setLoading(true);
        try {
            const data = await getPosts();
            setPosts(data);
        } catch (error) {
            console.error('Error al obtener los posts:', error);
            message.error('Error al obtener los posts');
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchPosts();
    }, []);

    const addPost = async (postData) => {
        try {
            const newPost = await createPost(postData);
            newPost.id = posts.length ? Math.max(...posts.map(p => p.id)) + 1 : 1;
            newPost.isLocal = true; // Marcar como local
            setPosts([newPost, ...posts]);
            message.success('Post creado exitosamente');
        } catch (error) {
            console.error('Error al crear el post:', error);
            message.error('Error al crear el post');
        }
    };

    const updatePost = async (id, postData) => {
        try {
            const updatedPost = await apiUpdatePost(id, postData);
            setPosts(posts.map(post => post.id === id ? {...post, ...updatedPost} : post));
            message.success('Post actualizado exitosamente');
        } catch (error) {
            console.error('Error al actualizar el post:', error);
            const postExists = posts.some(post => post.id === id);
            if (postExists) {
                setPosts(posts.map(post => post.id === id ? {...post, ...postData} : post));
                message.warning('API no pudo actualizar el post. Se actualizó localmente.');
            } else {
                message.error('No se pudo actualizar el post.');
            }
        }
    };

    const deletePost = async (id) => {
        Modal.confirm({
            title: '¿Estás seguro de eliminar este post?',
            content: 'Esta acción no se puede deshacer.',
            okText: 'Sí, eliminar',
            cancelText: 'Cancelar',
            onOk: async () => {
                try {
                    await apiDeletePost(id);
                    setPosts(posts.filter(post => post.id !== id));
                    message.success('Post eliminado exitosamente');
                } catch (error) {
                    console.error('Error al eliminar el post:', error);
                    const postExists = posts.some(post => post.id === id);
                    if (postExists) {
                        setPosts(posts.filter(post => post.id !== id));
                        message.warning('API no pudo eliminar el post. Se eliminó localmente.');
                    } else {
                        message.error('No se pudo eliminar el post.');
                    }
                }
            },
        });
    };

    return (
        <PostContext.Provider value={{
            posts,
            loading,
            addPost,
            updatePost,
            deletePost,
        }}>
            {children}
        </PostContext.Provider>
    );
};

export default PostContextProvider;
