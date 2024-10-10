import { useEffect, useState } from 'react';
import { Card, List, Typography, Spin, Divider, Tag } from 'antd';
import { getCommentsForPost } from '../api/comments';
import { getUserById } from '../api/users';
import UserInfo from './UserInfo';

const { Paragraph, Title } = Typography;

const PostDetail = ({ post }) => {
    const [comments, setComments] = useState([]);
    const [user, setUser] = useState(null);
    const [loading, setLoading] = useState(true);

    const fetchDetails = async () => {
        try {
            const [commentsData, userData] = await Promise.all([
                getCommentsForPost(post.id),
                getUserById(post.userId),
            ]);
            setComments(commentsData);
            setUser(userData);
        } catch (error) {
            console.error('Error al obtener detalles del post:', error);
            message.error('Error al obtener detalles del post');
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchDetails();
    }, [post]);

    if (loading) {
        return <Spin tip="Cargando detalles..." />;
    }

    return (
        <div>
            <Card title={
                <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                    {post.title}
                    {post.isLocal && <Tag color="blue">Local</Tag>}
                </div>
            } style={{ marginBottom: 16 }}>
                <Paragraph>{post.body}</Paragraph>
                {user && (
                    <>
                        <Divider />
                        <Title level={4}>Información del Usuario</Title>
                        <UserInfo user={user} />
                    </>
                )}
            </Card>
            <Card title="Comentarios">
                <List
                    dataSource={comments}
                    renderItem={(comment) => (
                        <List.Item key={comment.id}>
                            <List.Item.Meta
                                title={comment.name}
                                description={comment.body}
                            />
                        </List.Item>
                    )}
                />
            </Card>
        </div>
    );
};

export default PostDetail;
