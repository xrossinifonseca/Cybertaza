
if Color.count.zero?

  colors = [
    { name: 'red', hex_code: '#dc2626' },
    { name: 'green', hex_code: '#16a34a' },
    { name: 'blue', hex_code: '#2563eb' },
    {name:'gray',hex_code:"#6b7280"},
    {name:'purple',hex_code:"#9333ea"},
    {name:'pink',hex_code:"#db2777"},
    {name:'white',hex_code:"#fff"},
    {name:'black',hex_code:"#030712"},
  ]



  colors.each do |color|
    Color.create(color)
  end
end
