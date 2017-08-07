import googleapiclient.discovery
from pprint import pprint

PROJECT = "simsofast"
ZONE = "europe-west1-b"
NAME = "suckmycock"
MACHINE_TYPE = "zones/%s/machineTypes/n1-standard-1" % ZONE

compute = googleapiclient.discovery.build('compute', 'v1')

print('Creating instance.')

# Get the latest Debian Jessie image.
image_response = compute.images().getFromFamily(project='debian-cloud', family='debian-8').execute()
source_disk_image = image_response['selfLink']

# Configure the machine
# startup_script = open(os.path.join(os.path.dirname(__file__), 'startup-script.sh'), 'r').read()

config = {
    'name': NAME,
    'machineType': MACHINE_TYPE,

    # Specify the boot disk and the image to use as a source.
    'disks': [
        {
            'boot': True,
            'autoDelete': True,
            'initializeParams': {
                'sourceImage': source_disk_image,
            }
        }
    ],

    # Specify a network interface with NAT to access the public
    # internet.
    'networkInterfaces': [{
        'network': 'global/networks/default',
        'accessConfigs': [
            {'type': 'ONE_TO_ONE_NAT', 'name': 'External NAT'}
        ]
    }],

    # Allow the instance to access cloud storage and logging.
    'serviceAccounts': [{
        'email': 'default',
        'scopes': [
            'https://www.googleapis.com/auth/devstorage.read_write',
            'https://www.googleapis.com/auth/logging.write'
        ]
    }],

    # Metadata is readable from the instance and allows you to
    # pass configuration from deployment scripts to instances.
    'metadata': {
        'items': [{
            # Startup script is automatically executed by the
            # instance upon startup.
            'key': 'startup-script',
            'value': "echo hello cloud"
        }, {
            'key': 'ugga',
            'value': 'bugga'
        }]
    }
}

tmp = compute.instances().insert(project=PROJECT, zone=ZONE, body=config).execute()
pprint(tmp)
