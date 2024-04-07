bool isImageFromPath(String file) {
  if (file.toLowerCase() == "jpg" ||
      file.toLowerCase() == "png" ||
      file.toLowerCase() == "jpeg") {
    print('true');
    return true;
  } else {
    print('false');

    return false;
  }
}

bool isFileFromPath(String file) {
  if (file.toLowerCase() == "docx" ||
      file.toLowerCase() == "xlsx" ||
      file.toLowerCase() == "pdf") {
    return true;
  } else {
    return false;
  }
}

bool isVideoFromPath(String file) {
  if (file.toLowerCase() == "mp4" || file.toLowerCase() == "mov") {
    return true;
  } else {
    return false;
  }
}
