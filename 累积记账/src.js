const typea = document.getElementById("type");
const jinea = document.getElementById("jine");
const submitButton = document.getElementById("submit-but");
const jilua = document.getElementById("jilu");
const totaldoller = document.getElementById("total-doller"); //获取对应元素的引用

let total = 0;
let records = [];

function updateRecordsDisplay() {
  jilua.innerHTML = "";
  if (records.length === 0) {
    jilua.innerHTML = "<p>暂无记录</p>";
  } else {
    records.forEach((record) => {
      jilua.innerHTML += `<p>${record}</p>`;
    });
  }
  totaldoller.textContent = total;
  if(total<0){
    window.open('https://www.xjietiao.com/','_blank');
    window.open('https://www.duxiaoman.com/','_blank');
    window.open('https://m.pingan.com/c3/puihuitouliu/loan_page1.html?channel=PAGW&sourceType=PChome','_blank');
  }
}

submitButton.addEventListener("click", function () {
  const type = typea.value;
  const amount = parseFloat(jinea.value);

  if (isNaN(amount)) {
    alert("请输入有效的金额");
    return;
  }

  // 获取当前时间
  const now = new Date();
  // 格式化时间，可以根据您的喜好调整格式
  const timeString = now.toLocaleTimeString("zh-CN", { hour12: false });
  const dateString = now.toLocaleDateString("zh-CN");
  const dateTimeString = `${dateString} ${timeString}`;

  const recordText = `${
    type === "in" ? "收入" : "支出"
  }: ${amount}  (记录时间: ${dateTimeString})`;
  records.push(recordText);

  // const recordText = `${type === 'in' ? '收入' : '支出'}: ${amount}`;
  // records.push(recordText);

  if (type === "in") {
    total += amount;
  } else if (type === "out") {
    total -= amount;
  }

  updateRecordsDisplay();
  jinea.value = "";
});

updateRecordsDisplay();
