import setuptools

setuptools.setup(
    name='apachebeam',
    install_requires=[
        'apache-beam==2.40.0'
    ],
    packages=setuptools.find_packages(),
    include_package_data=True,

    # warnings suppressors
    description='Testing out Flex Templates',
    author='me',
    author_email='me@my.self',
    url='https://my.self/',
)