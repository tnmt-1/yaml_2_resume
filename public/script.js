($ => {
  const FILE_SIZE_LIMIT = 2 // 2mega
  $(() => {
    initEditor()
    initPhotoBtn()

    $(document)
      .on('click', '#photoBtn', () => {
        $('#photoInput').click()
      })
      .on('change', '#photoInput', ev => {
        const el = ev.currentTarget
        const file = el.files[0]
        if (file) {
          const fileSize = file.size
          if (fileSize > 1024 * 1024 * FILE_SIZE_LIMIT) {
            alert(`写真データを ${FILE_SIZE_LIMIT}m 以下にしてください！`)
            el.value = ''
          } else {
            setPhotoBtn(file)
          }
        } else {
          $('#photoBtn').text('写真をアップ')
        }
      })
  })
})(jQuery)

function initEditor() {
  const [dataYamlArea, styleTxtArea] = ['data_yml', 'style_txt'].map(id => {
    return document.getElementById(id)
  })
  if (!dataYamlArea || !styleTxtArea) {
    return
  }
  const editorOpt = {
    mode: "yaml",
    theme: 'eclipse',
    lineNumbers: true,
    indentUnit: 4
  }
  window.dataYamlEditor = CodeMirror.fromTextArea(dataYamlArea, editorOpt)
  window.styleTxtEditor = CodeMirror.fromTextArea(styleTxtArea, editorOpt)
  window.editorSave = () => {
    dataYamlEditor.save()
    styleTxtEditor.save()
    return true
  }
}

function initPhotoBtn() {
  const fileInput = document.querySelector('#photoInput')
  if (fileInput) {
    const file = fileInput.files[0]
    if (file) {
      setPhotoBtn(file)
    }
  }
}

function setPhotoBtn(file) {
  let fileName = file.name
  if (fileName.length > 10) {
    const l = fileName.length
    fileName = '...' + fileName.substring(l - 10, l)
  }
  $('#photoBtn').text(fileName)
}
