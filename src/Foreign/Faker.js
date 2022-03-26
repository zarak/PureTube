const { faker } = require("@faker-js/faker");

exports.avatar = function () {
  return faker.image.avatar();
};

exports.random = Math.random;
