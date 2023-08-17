import torch
cuda_avail = torch.cuda.is_available()
if cuda_avail:
    print("Torch CUDA is available")
    num_of_devices = torch.cuda.device_count()
    if num_of_devices:
        print("Number of CUDA devices: {}".format(num_of_devices))
        current_device = torch.cuda.current_device()
        current_device_id = torch.cuda.device(current_device)
        current_device_name = torch.cuda.get_device_name(current_device)
        print("Current device id: {}".format(current_device_id))
        print("Current device name: {}".format(current_device_name))
    else:
        print("No CUDA devices!")
else:
    print("Torch CUDA is not available!")
