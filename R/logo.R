#' inclusao da logo do cel em imagens
#'
#' @param endereco endereco da imagem que deseja incluir a logo do cel
#' @param escala_image por padadrao tem 2000px, escala_image = "2000". exemplo por dimensao escala_image = "400X400"
#' @param salvar logical, se TRUE salva o aquivo no diretorio.
#' @param nome nome do arquivo, se nao for escolhido sera salvo como nova_image_data.png
#' @param logo por padrao é usada a logo do CEL, mas pode ser substituido por outra imagem
#' @param escala_logo por padrao é "200x200"
#'
#'
#' @import magick
#' @export
#' @examples
#' \dontrun{
#' image_cel("foto.jpg")
#' }

image_cel <- function(endereco, escala_image = "2000",
                      salvar = TRUE, nome = "defualt",
                      logo = NULL,
                      escala_logo = "200x200"){

  if(is.null(logo)){
    imglogo <- image_read(system.file("logo/logo.png", package = "cel")) %>% image_scale(escala_logo)
  }else{
    imglogo <- image_read(logo) %>% image_scale(escala_logo)
  }



  infolog <- image_info(imglogo)

  img <- image_read(endereco) %>% image_scale(escala_image)

  infoimg <- image_info(img)

  off1 <- infoimg$width - infolog$width
  off2 <- infoimg$height - (infolog$height + 40)

  img <- image_composite(img, imglogo, offset = paste0("+", off1, "+", off2))

  if(salvar == T){

    if(nome == "defualt"){
      name <- paste0("nova_image_", Sys.Date(), ".png")
    }else{
      name <- nome
    }

    if(!file.exists(name)){
      image_write(img, name)
    }else{
      cat(paste0("esse arquivo ", name, " ja existe!, escolha outro nome"))
    }
  }

  img
}




