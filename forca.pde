String[] palavras = {"banana", "abacaxi", "morango", "cidade", "recife", "paris"};
String palavraEscolhida;
boolean[] letrasDescobertas;
int tentativasRestantes = 6;
String letrasTentadas = "";
boolean jogoEncerrado = false;
boolean mostrarBotao = false;

void setup() {
  size(400, 400);
  escolherPalavra();
}

void draw() {
  background(255);
  desenharForca();
  mostrarPalavra();
  mostrarTentativas();
  verificarFimDeJogo();
  if (mostrarBotao) desenharBotao();
}

void escolherPalavra() {
  palavraEscolhida = palavras[int(random(palavras.length))];
  letrasDescobertas = new boolean[palavraEscolhida.length()];
  tentativasRestantes = 6;
  letrasTentadas = "";
  jogoEncerrado = false;
  mostrarBotao = false;
}

void mostrarPalavra() {
  textSize(32);
  fill(0);
  textAlign(CENTER);
  String exibicao = "";
  for (int i = 0; i < palavraEscolhida.length(); i++) {
    if (letrasDescobertas[i]) {
      exibicao += palavraEscolhida.charAt(i) + " ";
    } else {
      exibicao += "_ ";
    }
  }
  text(exibicao, width / 2, height - 50);
}

void mostrarTentativas() {
  textSize(20);
  fill(0);
  textAlign(LEFT);
  text("Tentativas restantes: " + tentativasRestantes, 20, 30);
  text("Letras tentadas: " + letrasTentadas, 20, 60);
}

void desenharForca() {
  stroke(0);
  line(100, 300, 200, 300);
  line(150, 300, 150, 100);
  line(150, 100, 250, 100);
  line(250, 100, 250, 130);
  
  if (tentativasRestantes < 6) ellipse(250, 150, 40, 40); 
  if (tentativasRestantes < 5) line(250, 170, 250, 230);
  if (tentativasRestantes < 4) line(250, 190, 220, 210);
  if (tentativasRestantes < 3) line(250, 190, 280, 210);
  if (tentativasRestantes < 2) line(250, 230, 220, 270);
  if (tentativasRestantes < 1) line(250, 230, 280, 270);
}

void keyPressed() {
  if (jogoEncerrado) return;
  
  char letra = Character.toLowerCase(key);
  if (letrasTentadas.indexOf(letra) == -1 && Character.isLetter(letra)) {
    letrasTentadas += letra + " ";
    boolean acertou = false;
    for (int i = 0; i < palavraEscolhida.length(); i++) {
      if (palavraEscolhida.charAt(i) == letra) {
        letrasDescobertas[i] = true;
        acertou = true;
      }
    }
    if (!acertou) tentativasRestantes--;
  }
}

void verificarFimDeJogo() {
  boolean venceu = true;
  for (boolean descoberta : letrasDescobertas) {
    if (!descoberta) {
      venceu = false;
      break;
    }
  }
  
  if (venceu) {
    textSize(32);
    fill(0, 200, 0);
    textAlign(CENTER);
    text("Você venceu!", width / 2, height / 2);
    jogoEncerrado = true;
    mostrarBotao = true;
  } else if (tentativasRestantes == 0) {
    textSize(32);
    fill(200, 0, 0);
    textAlign(CENTER);
    text("Você perdeu!", width / 2, height / 2);
    jogoEncerrado = true;
    mostrarBotao = true;
  }
}

void desenharBotao() {
  fill(0, 0, 255);
  rect(width/2 - 50, height/2 + 40, 100, 40);
  fill(255);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("Jogar de Novo", width/2, height/2 + 60);
}

void mousePressed() {
  if (mostrarBotao && mouseX > width/2 - 50 && mouseX < width/2 + 50 && mouseY > height/2 + 40 && mouseY < height/2 + 80) {
    escolherPalavra();
  }
}
