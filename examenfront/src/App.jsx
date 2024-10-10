import {Layout, Typography} from 'antd';
import PostList from './components/PostList';

const {Header, Content} = Layout;
const {Title} = Typography;

const App = () => {
    return (
        <Layout style={{minHeight: '100vh'}}>
            <Header style={{background: '#001529', padding: '0 20px'}}>
                <div style={{display: 'flex', alignItems: 'center', height: '100%'}}>
                    <Title level={3} style={{color: '#fff', margin: 0}}>Examen técnico Frontend – React JS</Title>
                </div>
            </Header>
            <Content style={{padding: '20px 50px'}}>
                <PostList/>
            </Content>
        </Layout>
    );
};

export default App;
