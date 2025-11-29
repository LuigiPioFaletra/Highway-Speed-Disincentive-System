# MATLAB Project – Highway Speed Disincentive System (DVA)

This repository contains a MATLAB/Simulink project for the **DVA (Highway Speed Disincentive System)**.  
The system is designed to monitor vehicles on highways and ensure compliance with speed, weight, and engine displacement regulations.  
The project was developed as part of coursework in **Advanced Programming / Embedded Systems**.

The project implements:
- Sensor data acquisition via a wireless network (speed, weight, displacement)  
- Fuzzy logic controller for determining infractions  
- Controllers for fines, points, and traffic signage  
- Simulation of wireless/wired network communication and propagation delays  
- Real-time visualization of vehicle status and violations  

---

## Repository Structure

```
main_repository/
│
├── implementation/
│   ├── images/
│   │   ├── Controllore infrazione.png
│   │   ├── Controllore multa.png
│   │   ├── Controllore segnaletica.png
│   │   ├── Delay cilindrata.png
│   │   ├── Delay peso.png
│   │   ├── Delay velocità.png
│   │   ├── Display tempo di esecuzione.png
│   │   ├── Esempio logica stateflow 1.png
│   │   ├── Esempio logica stateflow 2.png
│   │   ├── Grafico complessivo.png
│   │   ├── Interfaccia grafica.png
│   │   ├── Limite massimo 130.png
│   │   ├── Limite minimo 80.png
│   │   ├── MBSD.png
│   │   ├── Pacchetti cilindrata inoltrati.png
│   │   ├── Pacchetti peso inoltrati.png
│   │   ├── Pacchetti velocità inoltrati.png
│   │   ├── Packet loss cilindrata.png
│   │   ├── Packet loss peso.png
│   │   ├── Packet loss velocità.png
│   │   ├── Struttura delay.png
│   │   ├── Struttura packet loss.png
│   │   ├── Topologia sistema.png
│   │   ├── TrueTime Network.png
│   │   ├── TrueTime Wireless Network.png
│   │   ├── Visione dettagliata gateway.png
│   │   ├── Visione dettagliata sensore cilindrata.png
│   │   ├── Visione dettagliata sensore peso.png
│   │   ├── Visione dettagliata sensore velocità.png
│   │   ├── Visione sintetica gateway.png
│   │   ├── Visione sintetica sensore cilindrata.png
│   │   ├── Visione sintetica sensore peso.png
│   │   └── Visione sintetica sensore velocità.png
│   │
│   ├── controller.fis
│   ├── displacementSensor_fnctn.m
│   ├── displacementSensor_init.m
│   ├── fineFlashPointsController_fnctn.m
│   ├── fineFlashPointsController_init.m
│   ├── fineFlashPointsNetHandler_fnctn.m
│   ├── gatewayNetHandler_fnctn.m
│   ├── gateway_fnctn.m
│   ├── gateway_init.m
│   ├── infringementController_fnctn.m
│   ├── infringementController_init.m
│   ├── infringementNetHandler_fnctn.m
│   ├── project.slx
│   ├── signageController_fnctn.m
│   ├── signageController_init.m
│   ├── signageNetHandler_fnctn.m
│   ├── speedSensor_fnctn.m
│   ├── speedSensor_init.m
│   ├── weightSensor_fnctn.m
│   └── weightSensor_init.m
│
├── description.pdf
├── LICENSE
└── README.md
```

---

## Project Overview

The goal of the DVA system is to detect and manage vehicle speed violations on highways:

- **Minimum speed**: 80 km/h  
- **Maximum speed**: 130 km/h  
- **Minimum vehicle weight**: 1.3 t  
- **Minimum engine displacement**: 250 cc  

Vehicles are monitored via three sensors:
1. **Speed sensor**  
2. **Weight sensor**  
3. **Displacement sensor**  

Sensor data is transmitted through a **wireless ZigBee network** to a **wired network** with controllers that calculate infractions, fines, points, and traffic signage.

---

## Workflow Summary

### **1. Wireless Network (Data Acquisition)**
- Sensors send data to a **gateway**  
- Gateway transmits data to the wired network  
- Wireless network is simulated with **packet loss and propagation delay**  

### **2. Wired Network (Controllers & Displays)**
- **Infringement Controller** → calculates infraction level (0–5)  
- **Fine Controller** → calculates fines and points based on infraction level  
- **Signage Controller** → displays green (safe) or yellow (violation) signals  
- **Gateway** → manages network communication and data flow  

### **3. Fuzzy Logic Controller**
- **Inputs**: Speed, Weight, Displacement  
- **Output**: Infraction Level  
- **Model**: Sugeno-type with 9 rules  

### **4. MATLAB Function**
- **Input**: Infraction Level (0–5)  
- **Outputs**: Fine, Flash (signage), Points  

### **5. Simulation**
- Platform: MATLAB/Simulink with **TrueTime 2.0**  
- Duration: 40 seconds  
- Monitors in real-time: speed, weight, displacement, infraction level, points, fines, and signage  
- Evaluates **packet reception accuracy** and **propagation delays**

---

## Technologies & Libraries Used

- **MATLAB & Simulink**  
- **TrueTime 2.0** (network simulation)  
- **Fuzzy Logic Toolbox**  
- Standard MATLAB functions for plotting and data analysis  

---

## Execution Steps

1. **Run the simulation**  
   - Duration: 40 seconds

2. **Monitor outputs in real-time**:  
   - Vehicle parameters (speed, weight, displacement)  
   - Infraction level  
   - Fines and points  
   - Signage signals (green/yellow)

3. **Optional**: modify sensor inputs or network parameters to test different scenarios

---

## Performance Evaluation

- **Packet reception accuracy** over 40 seconds:  
  - Speed: 92.31%  
  - Weight: 89.74%  
  - Displacement: 93.59%  

- **Propagation delay**: ~8% of sampling interval

---

## Notes

- The system is **preventive**; fines are **simulated** and not enforced.  
- **Scalable** to different highways or vehicles.  
- Can be enhanced with **solar panel energy management** using **Stateflow**.  
- Requires **MATLAB R2022a** or later with **Simulink** and **TrueTime** installed.
