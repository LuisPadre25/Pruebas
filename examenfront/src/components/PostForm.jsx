import { useEffect } from 'react';
import { Form, Input, Button } from 'antd';
import { useContext } from 'react';
import {PostContext} from "../context/Post.Context.jsx";


const { TextArea } = Input;

const PostForm = ({ post, onSuccess }) => {
    const [form] = Form.useForm();
    const { addPost, updatePost } = useContext(PostContext);

    useEffect(() => {
        if (post) {
            form.setFieldsValue({
                title: post.title,
                body: post.body,
            });
        } else {
            form.resetFields();
        }
    }, [post, form]);

    const onFinish = async (values) => {
        if (post) {
            await updatePost(post.id, values);
        } else {
            await addPost(values);
        }
        onSuccess();
    };

    return (
        <Form
            form={form}
            layout="vertical"
            onFinish={onFinish}
        >
            <Form.Item
                name="title"
                label="Título"
                rules={[{ required: true, message: 'Por favor ingresa el título del post' }]}
            >
                <Input placeholder="Ingresa el título del post" />
            </Form.Item>
            <Form.Item
                name="body"
                label="Contenido"
                rules={[{ required: true, message: 'Por favor ingresa el contenido del post' }]}
            >
                <TextArea rows={4} placeholder="Ingresa el contenido del post" />
            </Form.Item>
            <Form.Item>
                <Button type="primary" htmlType="submit" block>
                    {post ? 'Actualizar Post' : 'Crear Post'}
                </Button>
            </Form.Item>
        </Form>
    );
};

export default PostForm;
