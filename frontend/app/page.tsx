import { ArrowRightIcon } from '@heroicons/react/24/outline';
import Link from 'next/link';
import styles from '@/app/ui/home.module.css';
import { lusitana } from '@/app/ui/fonts';

export default function Page() {
	return (
		<main className='flex min-h-screen flex-col p-6'>
			<div className='mt-4 flex grow flex-col gap-4 md:flex-row'>
				<div className='flex flex-col justify-center gap-6 rounded-lg bg-gray-50 px-6 py-10 md:w-2/5 md:px-20'>
					<div className={styles.shape} />
					<p
						className={`${lusitana.className} antialiased text-xl text-gray-800 md:text-3xl md:leading-normal`}
					>
						<strong>Welcome to Beta Annual Fund.</strong>
						<br />
						Brought to you by Ifrahim A., Luke H.
					</p>
					<Link
						href='/dashboard'
						className='flex items-center gap-5 self-start rounded-lg bg-blue-500 px-6 py-3 text-sm font-medium text-white transition-colors hover:bg-blue-400 md:text-base'
					>
						<span>Get Started</span> <ArrowRightIcon className='w-5 md:w-6' />
					</Link>
				</div>
			</div>
		</main>
	);
}
