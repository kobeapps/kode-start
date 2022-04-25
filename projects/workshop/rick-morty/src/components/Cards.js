import React from "react";
import Card from "./Card";

const Cards = ({ cards }) => {
  return (
    <>
      {cards.map((article, index) => (
        <Card article={article} key={index} />
      ))}
    </>
  );
};

export default Cards;
