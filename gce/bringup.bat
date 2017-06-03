cmd /c gcloud compute --project "simsofast" instances create "fileserver" --zone "europe-west1-b" --machine-type "f1-micro" --subnet "default" --no-restart-on-failure --maintenance-policy "TERMINATE" --preemptible --image "debian-8-jessie-v20170523" --image-project "debian-cloud" --boot-disk-size "10" --boot-disk-type "pd-standard" --boot-disk-device-name "fileserver" --disk "name=shared,device-name=shared,mode=rw,boot=no" --address 104.199.93.48 --metadata-from-file startup-script=fileserver.sh

cmd /c gcloud compute --project "simsofast" instances create "masterworker" --zone "europe-west1-b" --machine-type "custom-24-22272" --subnet "default" --no-restart-on-failure --maintenance-policy "TERMINATE" --preemptible --image "debian-8-jessie-v20170523" --image-project "debian-cloud" --boot-disk-size "10" --boot-disk-type "pd-standard" --boot-disk-device-name "masterworker" --metadata-from-file startup-script=worker.sh

REM cmd /c gcloud compute --project "simsofast" instance-groups unmanaged create "main" --zone "europe-west1-b"
REM cmd /c gcloud compute --project "simsofast" instance-groups unmanaged add-instances "main" --zone "europe-west1-b" --instances "fileserver,masterworker"

REM gcloud compute --project "simsofast" ssh --zone "europe-west1-b" "master"

