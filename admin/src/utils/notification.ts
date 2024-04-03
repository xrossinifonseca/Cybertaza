import { useToast } from 'vue-toast-notification'

class Notification {
  private toast = useToast({
    position: 'top',
    duration: 3000
  })

  success(msg: string) {
    this.toast.success(msg)
  }

  error(msg: string) {
    this.toast.error(msg)
  }

  warning(msg: string) {
    this.toast.warning(msg)
  }
}

export const notification = new Notification()
