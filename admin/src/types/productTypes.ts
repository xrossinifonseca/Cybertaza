export type Product = {
  id: number
  name: string
  price: string
  color_id: number
  image_url: string
  color?: {
    id: number
    name: string
  }
}
