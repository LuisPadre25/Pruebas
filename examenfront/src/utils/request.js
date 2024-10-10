import axios from 'axios';
import {message} from 'antd';


const service = axios.create({
    baseURL: 'https://jsonplaceholder.typicode.com',
    timeout: 15000,
    headers: {
        'Content-Type': 'application/json',
    },
});

service.interceptors.response.use(
    (response) => {
        return response.data;
    },
    (error) => {
        if (error.response) {
            const {status, data} = error.response;
            switch (status) {
                case 400:
                    message.error(data?.message || 'Solicitud incorrecta');
                    break;
                case 401:
                    message.error(data?.message || 'No autorizado');
                    break;
                case 403:
                    message.error(data?.message || 'Prohibido');
                    break;
                case 404:
                    message.error(data?.message || 'Recurso no encontrado');
                    break;
                case 500:
                    message.error(data?.message || 'Error interno del servidor');
                    break;
                default:
                    message.error(data?.message || 'Ocurrió un error');
            }
        } else if (error.request) {
            message.error('No se recibió respuesta del servidor');
        } else {
            message.error('Error en la configuración de la solicitud');
        }

        console.error('Error de Axios:', error);

        return Promise.reject(error);
    }
);

export default service;
