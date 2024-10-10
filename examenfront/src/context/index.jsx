import PostContextProvider from "./Post.Context.jsx";
import App from "../App.jsx";

export default function () {
    return (
        <PostContextProvider>
            <App/>
        </PostContextProvider>
    )
}