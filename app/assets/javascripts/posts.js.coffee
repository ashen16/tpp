jQuery ->
  new ImageCrop()

class ImageCrop
  constructor: ->
    $('#crop').Jcrop
      aspectRatio: 1.5
      setSelect: [0, 0, 600, 600]
      onSelect: @update
      onChange: @update


  update: (coords) =>
    $('#post_crop_x').val(coords.x)
    $('#post_crop_y').val(coords.y)
    $('#post_crop_w').val(coords.w)
    $('#post_crop_h').val(coords.h)
    @updatePreview(coords)

  updatePreview: (coords) =>
    $('#preview').css
      width: Math.round(300/coords.w * $('#crop').width()) + 'px'
      height: Math.round(200/coords.h * $('#crop').height()) + 'px'
      marginLeft: '-' + Math.round(300/coords.w * coords.x) + 'px'
      marginTop: '-' + Math.round(200/coords.h * coords.y) + 'px'
