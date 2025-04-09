function kaishi() {
    const name = document.getElementById('name').value;
    const birthdateInput = document.getElementById('birthday').value;
    const resultDiv = document.getElementById('result');
    const xingzuoo = document.getElementById('xingzuo');
    const xinggeo = document.getElementById('xingge');

    if (!name || !birthdateInput) {
        alert('请填写完整的姓名和出生日期！');
        return;
    }

    const birthdate = new Date(birthdateInput);
    const month = birthdate.getMonth() + 1;
    const day = birthdate.getDate();

    const zodiacSign = getZodiacSign(month, day);
    const characterTrait = getCharacterTrait(name);

    xingzuoo.textContent = `您的星座是：${zodiacSign}`;
    xinggeo.textContent = `根据您的姓名，我们认为您是一个：${characterTrait}的人。`;
    resultDiv.style.display = 'block';
}

function getZodiacSign(month, day) {
    if ((month === 3 && day >= 21) || (month === 4 && day <= 19)) {
        return '白羊座';
    } else if ((month === 4 && day >= 20) || (month === 5 && day <= 20)) {
        return '金牛座';
    } else if ((month === 5 && day >= 21) || (month === 6 && day <= 21)) {
        return '双子座';
    } else if ((month === 6 && day >= 22) || (month === 7 && day <= 22)) {
        return '巨蟹座';
    } else if ((month === 7 && day >= 23) || (month === 8 && day <= 22)) {
        return '狮子座';
    } else if ((month === 8 && day >= 23) || (month === 9 && day <= 22)) {
        return '处女座';
    } else if ((month === 9 && day >= 23) || (month === 10 && day <= 23)) {
        return '天秤座';
    } else if ((month === 10 && day >= 24) || (month === 11 && day <= 22)) {
        return '天蝎座';
    } else if ((month === 11 && day >= 23) || (month === 12 && day <= 21)) {
        return '射手座';
    } else if ((month === 12 && day >= 22) || (month === 1 && day <= 19)) {
        return '摩羯座';
    } else if ((month === 1 && day >= 20) || (month === 2 && day <= 18)) {
        return '水瓶座';
    } else if ((month === 2 && day >= 19) || (month === 3 && day <= 20)) {
        return '双鱼座';
    }
    return '未知星座';
}

function getCharacterTrait(name) {
    const nameLength = name.length;
    if (nameLength <= 2) {
        return '真诚善良';
    } else if (nameLength <= 4) {
        return '聪明伶俐';
    } else {
        return '勤奋努力';
    }
}