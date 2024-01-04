import React, { useState } from 'react';
import { createRoot } from 'react-dom/client';

function Toggle() {
  const[text, setText ] = useState("ON")
  function handleClick() {
    // todo
    setText( text === "ON" ? "OFF" : "ON" )

  }
  
  return (
    <button onClick= {handleClick} >{text}</button>
  );
}

const container = document.getElementById('root');
const root = createRoot(container);
root.render(<Toggle />);