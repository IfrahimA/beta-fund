import './App.css';

//Pages
import { HomePage } from './components/HomePage';
import { Form1 } from './components/Form1';

import { createBrowserRouter, RouterProvider } from 'react-router-dom';

const router = createBrowserRouter([
	{
		path: '/',
		element: <HomePage />,
	},
	{
		path: '/form-1',
		element: <Form1 />,
	},
]);

function App() {
	return (
		<div>
			<RouterProvider router={router} />
		</div>
	);
}

export default App;
