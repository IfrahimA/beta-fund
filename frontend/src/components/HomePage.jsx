import { Link } from 'react-router-dom';

export const HomePage = () => {
	return (
		<div className='flex flex-col justify-center items-center h-screen'>
			<div className='text-yellow-600 font-bold text-5xl pb-8'>
				BETA UNIVERSITY ANNUAL FUND
			</div>
			<Link
				to='/form-1'
				className='outline p-2 rounded text-yellow-600 hover:text-yellow-700 transition'
			>
				Getting Started
			</Link>
		</div>
	);
};
