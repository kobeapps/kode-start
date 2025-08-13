import React from "react";

const Card = ({ detail }) => {
  console.log(detail);
  const { name, firstEpisode, lastLocation, specie, status, image } =
    detail.fields;
  return (
    <div className="cardCaracter">
      <div className="image">
        {image && (
          <img className="image" src={image.fields.file.url} alt={name} />
        )}
      </div>
      <div className="card">
        <h2> {name}</h2>
        <span className={`status ${status}`}>
          <span className="icon"></span>
          {status} - {specie}
        </span>
        <div className="cardContent">
          <span className="text">
            <strong>Last know Location: </strong>
            {lastLocation}
          </span>
        </div>
        <div className="cardContent">
          <span className="text">
            <strong>First Seen in: </strong>
            {firstEpisode}
          </span>
        </div>
      </div>
    </div>
  );
};

export default Card;
