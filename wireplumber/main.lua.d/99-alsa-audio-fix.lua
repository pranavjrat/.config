# WirePlumber configuration for Intel Tiger Lake audio
# Prevents stuttering and improves audio quality

monitor.alsa.properties = {
    # ALSA monitoring settings
    alsa.reserve = false
    alsa.disable-mmap = false
    alsa.disable-batch = false
    
    # Intel Tiger Lake specific settings
    api.alsa.period-size = 1024
    api.alsa.period-num = 2
    api.alsa.headroom = 1024
    
    # Quality settings
    audio.format = "S32LE"
    audio.rate = 48000
    audio.channels = 2
    audio.position = "FL,FR"
    
    # Latency settings
    node.latency = 1024/48000
    resample.quality = 10
}

monitor.alsa.rules = [
    {
        matches = [
            { node.name = "~alsa_input.*" }
            { node.name = "~alsa_output.*" }
        ]
        actions = {
            update-props = {
                audio.format = "S32LE"
                audio.rate = 48000
                api.alsa.period-size = 1024
                api.alsa.period-num = 2
                api.alsa.headroom = 1024
                session.suspend-timeout-seconds = 0
                node.pause-on-idle = false
            }
        }
    }
    {
        matches = [
            { device.name = "~alsa_card.pci-0000_00_1f.3.*" }
        ]
        actions = {
            update-props = {
                device.profile.set = "HiFi"
                api.alsa.use-acp = true
                api.alsa.soft-mixer = false
                api.alsa.ignore-dB = false
            }
        }
    }
]
