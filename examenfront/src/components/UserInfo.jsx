import {Card} from 'antd';

const UserInfo = ({user}) => {
    return (
        <Card type="inner" title="Información del Usuario">
            <p><strong>Nombre:</strong> {user.name}</p>
            <p><strong>Username:</strong> {user.username}</p>
            <p><strong>Email:</strong> {user.email}</p>
            <p>
                <strong>Dirección:</strong> {`${user.address.street}, ${user.address.suite}, ${user.address.city}, ${user.address.zipcode}`}
            </p>
            <p><strong>Teléfono:</strong> {user.phone}</p>
            <p><strong>Website:</strong> {user.website}</p>
        </Card>
    );
};

export default UserInfo;
