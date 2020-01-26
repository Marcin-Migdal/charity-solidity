pragma solidity ^0.4.26;


contract CharityExample {

  // struct jest to typ zmiennych który umożliwia nam stworzenie swojego typu danych
  struct Charity {
    string title;
    string description;
    // typ zmiennych który umożliwia przechowywanie adresu kont w sieci etherium
    address charityAddress;
    uint requiredAmountToSend;
    uint charityEther;
    uint contributorsCount;
    bool isCompleted;
    uint index;
  }

  // stworzenie zmiennej będącej listą przechowującą typ struct który wcześniej stworzyliśmy
  Charity[] public charities;
  address public manager;

  constructor () public {
    manager = msg.sender;
  }

  // modifier jest to słowo które tworzy nam funkcje która umożliwia nam zaoszczędzenie kodu poprzez
  // nie duplikowania go, działa to w ten sposób że w deklaracji normalnej funkcji dodajemy nazwe funkcji
  // modifier w tym przepadku jest to restrictedToManager, wtedy wykonując normalną funkcje najpierw wykona się
  // kod z naszej funkcji modifier i dopiero wtedy wykona sie reszta funkcji w miejscu znaku "_"
  modifier restrictedToManager(){
    // require jest to funkcja działąjaca w podobny sposób do if'a,
    // mianowicie jeżeli przez operacje wykonaną w require nie zostanie zwrócone true
    // to wykonywanie kodu zostanie zatrzymane, to co sie różni od normalnego if'a to jest to że
    // w momencie w którym operacja w require zwróci false pakaże sie błąd mówiący co i w którym miejscu sie stało
    require(manager == msg.sender);
    _;
  }

  // w tym przypadku w pierwszej kolejności wykona sie kod z modifier'a restrictedToManager,
  // dopiero później jeżeli wszystko wykona sie bez przeszkód wykona sie kod z funkcji addCharity()
  function addCharity (string newtitle, string newDescription, address newCharityAddress,
                       uint newRequiredAmountToSend) public restrictedToManager payable {
    charities.push(newCharity(newtitle, newDescription, newCharityAddress, newRequiredAmountToSend));
  }

  function newCharity (string newTitle, string newDescription,
                       address newCharityAddress, uint newRequiredAmountToSend) private view returns (Charity){
    Charity memory charity = Charity({
      title: newTitle,
      description: newDescription,
      charityAddress: newCharityAddress,
      requiredAmountToSend: newRequiredAmountToSend,
      charityEther: msg.value,
      contributorsCount: 1,
      isCompleted: false,
      index: charities.length
    });
    return charity;
  }

  // modifier payable oznacza to że wykonujemy w daje funkcji jakąś operacje na etherium
  function contributeToCharity(uint charityIndex) public payable {
    require(charities[charityIndex].isCompleted == false);
    charities[charityIndex].charityEther += msg.value;
    if(charities[charityIndex].requiredAmountToSend <= charities[charityIndex].charityEther){
      // aby wysłać ether na adress zmiennej która przechowuje adres możemy wykonać funkcje transfer
      // która wysyła ether na ten właśnie adres, w argumencie funkcji transfer podajemy ilość
      // etheru która chcemy wysłać
      charities[charityIndex].charityAddress.transfer(charities[charityIndex].charityEther);
      charities[charityIndex].isCompleted = true;
    }
  }
  
  function charitiesLength() public view returns(uint) {
      return charities.length;
  }
}