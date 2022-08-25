module.exports = function (mixin, minHeight = '32px', minWidth = null) {
  let declarations = {
    position: 'absolute',
    top: '50%',
    left: '50%',
    width: '100%',
    height: '100%',
    'min-height': minHeight,
    content: '""',
    transform: 'translateX(-50%) translateY(-50%)'
  }

  if (minWidth) {
    declarations['min-width'] = minWidth
  }

  return {
    '&': declarations
  }
}
