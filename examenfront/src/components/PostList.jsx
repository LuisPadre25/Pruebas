import {useContext, useState, useEffect, useCallback} from 'react';
import {List, Button, Spin, Input, Row, Col, Pagination, Modal} from 'antd';
import {PlusOutlined} from '@ant-design/icons';
import PostForm from './PostForm';
import PostDetail from './PostDetail';
import debounce from 'lodash.debounce';
import {PostContext} from "../context/Post.Context.jsx";


const {Search} = Input;

const POSTS_PER_PAGE = 10;

const PostList = () => {
    const {posts, loading, deletePost} = useContext(PostContext);
    const [filteredPosts, setFilteredPosts] = useState([]);
    const [selectedPost, setSelectedPost] = useState(null);
    const [isModalVisible, setIsModalVisible] = useState(false);
    const [isDetailVisible, setIsDetailVisible] = useState(false);
    const [currentPage, setCurrentPage] = useState(1);

    useEffect(() => {
        setFilteredPosts(posts);
    }, [posts]);

    const handleDelete = (id) => {
        deletePost(id);
    };

    const handleEdit = (post) => {
        setSelectedPost(post);
        setIsModalVisible(true);
    };

    const handleView = (post) => {
        setSelectedPost(post);
        setIsDetailVisible(true);
    };

    const handleFormSuccess = () => {
        setIsModalVisible(false);
        setSelectedPost(null);
    };

    const handleAdd = () => {
        setSelectedPost(null);
        setIsModalVisible(true);
    };

    const handleSearch = (value) => {
        const filtered = posts.filter(post =>
            post.title.toLowerCase().includes(value.toLowerCase())
        );
        setFilteredPosts(filtered);
        setCurrentPage(1);
    };

    const debouncedSearch = useCallback(debounce(handleSearch, 300), [posts]);

    const onSearchChange = (e) => {
        debouncedSearch(e.target.value);
    };

    const handlePageChange = (page) => {
        setCurrentPage(page);
    };

    const startIndex = (currentPage - 1) * POSTS_PER_PAGE;
    const endIndex = startIndex + POSTS_PER_PAGE;
    const currentPosts = filteredPosts.slice(startIndex, endIndex);

    if (loading) {
        return <Spin tip="Cargando posts..."/>;
    }

    return (
        <div>
            <Row justify="space-between" align="middle" gutter={[16, 16]} style={{marginBottom: '20px'}}>
                <Col xs={24} sm={16}>
                    <Search
                        placeholder="Buscar por título"
                        allowClear
                        enterButton="Buscar"
                        size="large"
                        onChange={onSearchChange}
                        style={{width: '100%'}}
                    />
                </Col>
                <Col xs={24} sm={6}>
                    <Button type="primary" icon={<PlusOutlined/>} onClick={handleAdd} block>
                        Agregar Post
                    </Button>
                </Col>
            </Row>
            <List
                grid={{
                    gutter: 16,
                    xs: 1,
                    sm: 2,
                    md: 3,
                    lg: 4,
                    xl: 4,
                    xxl: 4,
                }}
                dataSource={currentPosts}
                renderItem={(post) => (
                    <List.Item key={post.id} style={{backgroundColor: 'white', padding: 12, borderRadius: 12}}>
                        <List.Item.Meta
                            title={post.title}
                            description={post.body.length > 100 ? `${post.body.substring(0, 100)}...` : post.body}
                        />
                        <div style={{marginTop: '10px'}}>
                            <Button type="link" onClick={() => handleView(post)}>Ver</Button>
                            <Button type="link" onClick={() => handleEdit(post)}>Editar</Button>
                            <Button type="link" danger onClick={() => handleDelete(post.id)}>Eliminar</Button>
                        </div>
                    </List.Item>
                )}
            />
            <Pagination
                current={currentPage}
                pageSize={POSTS_PER_PAGE}
                total={filteredPosts.length}
                onChange={handlePageChange}
                style={{textAlign: 'center', marginTop: '20px'}}
                showSizeChanger={false}
            />
            <Modal
                title={selectedPost ? 'Editar Post' : 'Agregar Post'}
                visible={isModalVisible}
                footer={null}
                onCancel={() => {
                    setIsModalVisible(false);
                    setSelectedPost(null);
                }}
            >
                <PostForm post={selectedPost} onSuccess={handleFormSuccess}/>
            </Modal>
            <Modal
                title="Detalle del Post"
                visible={isDetailVisible}
                footer={null}
                onCancel={() => {
                    setIsDetailVisible(false);
                    setSelectedPost(null);
                }}
                width={800}
            >
                {selectedPost && <PostDetail post={selectedPost}/>}
            </Modal>
        </div>
    );

};

export default PostList;
