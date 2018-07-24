


const simpleCalc = (str) => {

  for (var j = 0; j < str.length; j++) {
    if (str[j] === '-' || str[j] === '+') {
      break;
    }
  }
  let sum = parseInt(str.slice(0, j));
  // console.log(sum);
  let plusMinus; 
  let num = ""; 
  for (let i = j; i < str.length; i++) {
    if (str[i] === '+') {
      plusMinus = 1;
    } else if (str[i] === '-') {
      plusMinus = 0;
    } else {
        // console.log(str[i]);
        // console.log(num);
        if (str[i + 1] === '+' || str[i + 1] === '-' || i === str.length-1) {
          num += str[i];
          plusMinus ? sum += parseInt(num) : sum -= parseInt(num);
          num = "";
        } else {
          num += str[i];
        }
    }
  }
  console.log(sum);
  return sum;

}

const expr = "16+7+5-2+3-17+20";
simpleCalc(expr);