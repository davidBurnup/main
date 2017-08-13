angular.module('Burnup.controllers.ActivitiesNewModal', ['ngFileUpload'])

.controller 'ActivitiesNewModal', ($scope, $timeout, $uibModalInstance, withPhoto, Auth, Post, Upload, $http, recipientType, recipientId) ->

  $scope.withPhoto = withPhoto
  $scope.showPhoto = ->
    $scope.withPhoto = true

  $scope.currentUser = Auth.currentUser(camelize: true)
  
  new Post(
   content: ""
   isDraft: true
   recipientType: recipientType,
   recipientId: recipientId
  ).save().then (post) ->
    if post and post.medias? and post.medias.length > 0
      for media in post.medias
        console.log "media", media
        $scope.files.push {
          id: media.id
          type: media.attachment.contentType # Refers to the mime type of the file "application/pdf"
          name: media.attachment.fileName
          attachmentThumb: media.attachment.thumb
          progress: 100
        }
    $scope.post = post

  $scope.files = []

  $('.modal-backdrop').addClass('visible')

  $scope.close = ->
    if !$scope.savingPost
      $('.modal-backdrop').removeClass('visible')
      $uibModalInstance.close()

  $scope.save = ($event) ->
    $event.preventDefault()
    $scope.savingPost = true
    $scope.post.isDraft = false
    $scope.post.save()
    .then (activity) ->
      $scope.savingPost = false
      $('.modal-backdrop').removeClass('visible')
      $uibModalInstance.close(activity)

  $scope.upload = (files, invalidFiles) ->
    console.log "files", invalidFiles
    $scope.invalidFiles = []

    # Add the files to the files queue
    if angular.isArray(files)
      $scope.files = $scope.files.concat(files)
    else
      $scope.files.push files

    if angular.isArray(invalidFiles) and invalidFiles.length > 0
      for invalidFile in invalidFiles
        errorsLabels = {}
        for errorMessage of invalidFile.$errorMessages
          errorsLabels[errorMessage] = {}
          switch errorMessage
            when "minSize"
              errorsLabels[errorMessage]['label'] = "Taille insuffisante"
              errorsLabels[errorMessage]['popover'] = "Veuillez choisir un fichier d'une taille supérieure à 10KB."
            when "maxSize"
              errorsLabels[errorMessage]['label'] = "Fichier trop volumineux"
              errorsLabels[errorMessage]['popover'] = "Veuillez choisir un fichier d'une taille inférieure à 50MB."
            when "dimensions"
              errorsLabels[errorMessage]['label'] = "Dimensions non conformes"
              errorsLabels[errorMessage]['popover'] = "Veuillez choisir un fichier ayant une taille d'image d'au moins 500x500 pixel."
            when "maxFiles"
              errorsLabels[errorMessage]['label'] = "Nombre de fichiers limités"
              errorsLabels[errorMessage]['popover'] = "Merci de ne choisir que 5 fichiers maximum."
        invalidFile.errorsLabels = errorsLabels

        $scope.invalidFiles.push invalidFile

    # And upload them !
    for file in files
      $scope.uploadFile(file)

  $scope.uploadFile = (file) ->
    if $scope.post?
      file.upload = Upload.upload
        # url: 'https://angular-file-upload-cors-srv.appspot.com/upload'
        url: '/api/medias.json'
        method: 'POST'
        headers:
          'Content-Type': file.type
        ignoreLoadingBar: true
        data:
          media:
            attachment: file
            post_id: $scope.post.id

      file.upload.then ((response) ->
        $timeout ->
          # file.result = response.data[0]
          media = response.data
          console.log "rr", media, response
          if media?
            file.id = media.id
            if media.image?
              file.attachmentThumb = media.image.mini
          return
        return
      ), ((response) ->
        if response.status > 0
          $scope.errorMsg = response.status + ': ' + response.data
        return
      ), (evt) ->
        # Math.min is to fix IE which reports 200% sometimes
        file.progress = Math.min(100, parseInt(100.0 * evt.loaded / evt.total))
    return

  $scope.deleteAttachment = (file) ->
    if confirm("Voulez-vous vraiment supprimer cette pièce d'identité ?") and file? and file.id?
      $http.delete("/api/medias/#{file.id}.json").then ->
        $scope.files = $scope.files.filter (existingFile) ->
          existingFile.id isnt file.id

  $scope.fileIsAnImage = (type) ->
    type in ['image/jpeg', 'image/png', 'image/gif', 'image/jpg']
