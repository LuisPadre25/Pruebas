import request from "../utils/request.js";

export const getPosts = () => {
    return request.get('/posts');
};

export const getPostById = (id) => {
    return request.get(`/posts/${id}`);
};

export const createPost = (postData) => {
    return request.post('/posts', postData);
};

export const updatePost = (id, postData) => {
    return request.put(`/posts/${id}`, postData);
};

export const deletePost = (id) => {
    return request.delete(`/posts/${id}`);
};
