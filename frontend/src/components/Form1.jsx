export const Form1 = () => {
	return (
		<div className='h-screen flex flex-col justify-center items-center'>
			<div className='text-4xl font-bold'>Enter Donation:</div>
			<form action='#' className='flex flex-col outline rounded mt-4'>
				<div className='flex gap-4 p-4 hover:text-2xl transition-all'>
					<label htmlFor='first-name' className='w-32'>
						First Name:
					</label>
					<input
						type='text'
						className='rounded outline outline-1 pl-1 w-full '
					/>
				</div>

				<div className='flex gap-4 p-4'>
					<label htmlFor='last-name' className='w-32'>
						Last Name:
					</label>
					<input
						type='text'
						className='rounded outline outline-1 pl-1 w-full'
					/>
				</div>

				<div className='flex gap-4 p-4'>
					<label htmlFor='address' className='w-32'>
						Address:
					</label>
					<input
						type='text'
						className='rounded outline outline-1 pl-1 w-full'
					/>
				</div>

				<div className='flex gap-4 p-4'>
					<label htmlFor='phone' className='w-32'>
						Phone Number:
					</label>
					<input
						type='text'
						className='rounded outline outline-1 pl-1 w-full'
					/>
				</div>

				<div className='flex gap-4 p-4'>
					<label htmlFor='email' className='w-32'>
						Email:
					</label>
					<input
						type='text'
						className='rounded outline outline-1 pl-1 w-full'
					/>
				</div>
			</form>
		</div>
	);
};
