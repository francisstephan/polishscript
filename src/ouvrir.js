openDic = function (id){
  var text = document.getElementById(id).innerHTML ;
  let result = text.replace(/ /g, "+");
  var chaine="https://context.reverso.net/translation/polish-english/"+result;
  window.open(chaine);
  document.getElementById("entree").focus();
}
