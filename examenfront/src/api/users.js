import request from "../utils/request.js";

export const getUserById = (id) => {
    return request.get(`/users/${id}`);
};
