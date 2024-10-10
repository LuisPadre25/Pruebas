import request from "../utils/request.js";

export const getCommentsForPost = (postId) => {
    return request.get(`/posts/${postId}/comments`);
};
