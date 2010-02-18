function FourSixCachedTest(v) {
  // Load the items data, and parse it
  obj = JSON.parse(v.values[0].data);
  if (obj.batch && obj.batch == '513') {
    return [obj];
  }
  else {
    return []; 
  }
}
