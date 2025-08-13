import React from "react";
import Card from "./Card";

const Cards = ({ cards }) => {
  return (
    <>
      {cards.map((detail, index) => (
        <Card detail={detail} key={index} />
      ))}
    </>
  );
};

export default Cards;
