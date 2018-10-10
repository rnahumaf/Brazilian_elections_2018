library('rvest')
  
  # Obtain information from candidates to the Chamber of Deputies in 2018
  page1=read_html("https://especiais.gazetadopovo.com.br/eleicoes/2018/candidatos/sp/deputado-federal/")
  links1 <- page1 %>% html_nodes(".cor-preto") %>% html_attr('href')
  
  length(links1)
  links1[1685] # Last candidate listed in the webpage

  df1 <- matrix(ncol=5)
  df1 <- NULL
  for(i in 1048:1685){
    print(i)
    candidato1=read_html(links1[i])
    linha1 <- candidato1 %>% 
      html_nodes(".situacao-candidatura strong, 
                        .table-dados-pessoais tr:nth-child(6) td,
                        #cont-left tr:nth-child(6) td,
                        .table-dados-pessoais tr:nth-child(1) td,
                        #cont-left tr:nth-child(2) td") %>%
      html_text()
    df1 <- rbind(df1, linha1)
  }
  
  print(df1)  
  
  write.csv(df1, "Federais.csv")
