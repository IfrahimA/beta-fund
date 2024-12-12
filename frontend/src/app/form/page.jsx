'use client';

import { useState } from 'react';

export default function Page() {
	const [firstName, setFirstName] = useState('');
	const [lastName, setLastName] = useState('');
	const [email, setEmail] = useState('');
	const [phoneNumber, setPhoneNumber] = useState('');
	const [donation, setDonation] = useState('');
	const [classYear, setClassYear] = useState('');
	const [category, setCategory] = useState('');

	return (
		<div className='min-h-screen flex justify-center items-center'>
			<form className='w-full max-w-md px-4'>
				<div className='mb-4'>
					<label className='block text-sm font-medium text-gray-700'>
						First Name
					</label>
					<input
						type='text'
						id='firstName'
						name='firstName'
						className='mt-1 p-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-orange-500 focus:border-orange-500 block w-full'
					/>
				</div>

				<div className='mb-4'>
					<label className='block text-sm font-medium text-gray-700'>
						Last Name
					</label>
					<input
						type='text'
						id='lastName'
						name='lastName'
						className='mt-1 p-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-orange-500 focus:border-orange-500 block w-full'
					/>
				</div>

				<div className='mb-4'>
					<label className='block text-sm font-medium text-gray-700'>
						Email (Optional)
					</label>
					<input
						type='email'
						id='email'
						name='email'
						className='mt-1 p-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-orange-500 focus:border-orange-500 block w-full'
					/>
				</div>

				<div className='mb-4'>
					<label className='block text-sm font-medium text-gray-700'>
						Phone Number (Optional)
					</label>
					<input
						type='tel'
						id='phone'
						name='phone'
						className='mt-1 p-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-orange-500 focus:border-orange-500 block w-full'
					/>
				</div>

				<div className='mb-4'>
					<label className='block text-sm font-medium text-gray-700'>
						Donation Amount
					</label>
					<input
						type='number'
						id='donationAmount'
						name='donationAmount'
						class='mt-1 p-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-orange-500 focus:border-orange-500 block w-full'
					/>
				</div>

				<div className='mb-4'>
					<label className='block text-sm font-medium text-gray-700'>Class</label>
					<select
						id='class'
						name='class'
						className='mt-1 p-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-orange-500 focus:border-orange-500 block w-full'
					>
						<option value='Alumni'>Alumni</option>
						<option value='Parent'>Parent</option>
						<option value='Family'>Family</option>
						<option value='Faculty'>Faculty</option>
						<option value='Student'>Student</option>
						<option value='Other'>Other</option>
					</select>
				</div>

				<div className='mb-4'>
					<label className='block text-sm font-medium text-gray-700'>
						Payment Method
					</label>
					<select
						id='payment'
						name='payment'
						className='mt-1 p-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-orange-500 focus:border-orange-500 block w-full'
					>
						<option value='credit'>Credit Card</option>
						<option value='debit'>Debit Card</option>
						<option value='deferred'>Deferred Payment</option>
					</select>
				</div>

				<button
					type='submit'
					className='bg-orange-500 hover:bg-orange-700 text-white font-bold py-2 px-4 rounded'
				>
					Submit
				</button>
			</form>
		</div>
	);
}
