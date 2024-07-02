Parametro
LoteInicial_8(8);
LoteReinicial_2(4);
Inicio_das_Ordens_HHMM(0900);
Fim_das_Entradas_HHMM(1700);
FechamentoGeral_HHMM(1700);
var
  aag,raag,m110,m17,mm200,mm,mmd,a,mm17,m750,m5000,ultcompra,ultvenda,dPrice,mm1,mm2,mm3,mm4,vHMA,vHMA2,T: real;
  sinalC,sinalC1,sinalV,sinalV1,sinalzTFC,sinalzTFV: boolean;
  p: integer;


begin
///////////////////////////////////////////////CÓDIGO-14R////////////////////////////////////////////////


 begin
  aag := 0;
  if (AccAgressSaldo(1) <> 0) then
    aag := (AccAgressSaldo(1)/500)+abertura; 
  raag := aag;
  if (aag[1] <> 0) then
    raag := (aag / aag[1]) * aag;
  mm200 := MediaExp(200, Fechamento);
  mmd := MediaExp(1, mm[4]);
  mm := MediaExp(17, Fechamento);
  m110 := MediaExp(110,(AccAgressSaldo(1)/500)+abertura); //110
  a:= Fechamento-m110+mm200; 
  m17 := MediaExp(17,(AccAgressSaldo(1)/500)+abertura);//similar a mm
  mm17 := MediaExp(1, m17[4]);
  m750 := MediaExp(750,(AccAgressSaldo(1)/500)+abertura);
  m5000 := MediaExp(5000,(AccAgressSaldo(1)/500)+abertura);
  T := (mm200+m110+mm+m17)/4;
  
  p:=Round(IntPortion(Sqrt(17)));
  mm1 :=WAverage(mm, Round(IntPortion(17/2))); 
  mm2 :=WAverage(mm, 17);
  vHMA :=WAverage(2*mm1-mm2,p);

  p:=Round(IntPortion(Sqrt(17)));
  mm3 :=WAverage(m17, Round(IntPortion(17/2))); 
  mm4 :=WAverage(m17, 17);
  vHMA2 :=WAverage(2*mm3-mm4,p);

  //if (abs(vHMA-vHMA[25])<100)and(abs(m17-m17[25])<120)and(abs(m110-m110[25])<70)and(abs(m750-m750[25])<50)then
  //PaintBar(rgb(210,180,140));
  //if (abs(vHMA-m110)<50)and(abs(vHMA-m17)<50)and(abs(vHMA-open)<50)then
  //PaintBar(rgb(70,130,180));   //Flat
  //if (close[12]<close[11])and(close[11]<close[10])and(close[10]<close[9])and(close[9]<close[8])and(close[8]<close[7])and(close[7]<close[6])and(close[6]<close[5])and(close[5]<close[4])and(close[4]<close[3])and(close[3]<close[2])and(close[2]<close[1])and(close[1]<close)then
  //PaintBar(rgb(50,205,50));  //Compra
  //if (close[12]>close[11])and(close[11]>close[10])and(close[10]>close[9])and(close[9]>close[8])and(close[8]>close[7])and(close[7]>close[6])and(close[6]>close[5])and(close[5]>close[4])and(close[4]>close[3])and(close[3]>close[2])and(close[2]>close[1])and(close[1]>close)then
  //PaintBar(rgb(220,20,60));    //Venda
///////////////////////////////////////////////PLOTAGENS/////////////////////////////////////////////////
  //if (aag=0) then  noplot(1)
  //else Plot(aag);   //Branco              Rapida 8 
  //if (raag=0) then  noplot(2)
  //else Plot2(raag); //AzulClaro           Rapida 9
  Plot3(mm200);       //Azul                Rapida 1
  Plot4(mmd);         //Amarela Tracejada   Rapida 4
  Plot5(mm);          //Vermelha            Rapida 5
  Plot6(m110);        //Prata3x             Rapida 2
  //Plot7(T);           //Laranja             Rapida 7
  Plot8(m17);         //Prata2x             Rapida 6
  Plot9(mm17);        //Prata Tracejada     Rapida 3,
  if (m750=0) then  noplot(10)
  else Plot10(m750);  //Prata4x
  if (m5000=0) then  noplot(11)
  else Plot11(m5000); //Prata5x

  if (vHMA=0) then noplot(12)
  else Plot12(vHMA);
  //if (vHMA2=0) then noplot(13)
  //else Plot13(vHMA2);
    
//////////////////////////////////////////////////CORES//////////////////////////////////////////////////
  SetPlotColor(1,clBranco);
  SetPlotColor(2,rgb(0,255,255));              
  SetPlotColor(3,rgb(0,128,255));
  SetPlotColor(4,rgb(255,255,0));
  SetPlotStyle(4,1);
  SetPlotColor(5,rgb(255,0,0));
  SetPlotColor(6,clPrata);
  SetPlotWidth(6,3);
  SetPlotColor(7,rgb(255,128,0));    
  SetPlotColor(8,clPrata);
  SetPlotWidth(8,2);
  SetPlotColor(9,clPrata);
  SetPlotWidth(9,1);
  SetPlotStyle(9,1);
  SetPlotColor(10,clcinza);       
  SetPlotWidth(10,4);
  SetPlotColor(11,clcinza);       
  SetPlotWidth(11,5);
  SetPlotColor(12,clverde);       
  SetPlotWidth(12,3);
  SetPlotColor(13,rgb(70,130,180));       
  SetPlotWidth(13,3);
 end;

 //if (abertura<fechamento)and((mm[1]<mmd[1])and(mm>mmd))and(abs(vHMA-vHMA[14])<150)and(abs(m17-m17[14])<150)and(abs(mmd-mmd[14])<150)and(abs(m110-m110[14])<150)then
  //PaintBar(rgb(210,180,140));
///////////////////////////////////////////////OPERACIONAL///////////////////////////////////////////////
  
             ///////////////////////////////////ENTRADAS///////////////////////////////////

  sinalC :=(abs(fechamento-m5000)>250)and((abs(fechamento[1]-m110[1]))<(abs(fechamento-m110)))and(abs(fechamento-mm)>150)and(abs(vHMA-vHMA[14])<300)and(abs(m17-m17[14])<300)and(abs(mmd-mmd[14])<300)and(abs(m110-m110[14])<300)and(abertura<fechamento);  //distancia da m110
  sinalC1 :=(abs(fechamento-m5000)>250)and((abs(fechamento[1]-m110[1]))>(abs(fechamento-m110)))and(abs(fechamento-mm)>150)and(abs(vHMA-vHMA[14])<300)and(abs(m17-m17[14])<300)and(abs(mmd-mmd[14])<300)and(abs(m110-m110[14])<300)and(abertura<fechamento); //aproxima da m110

  sinalV :=(abs(fechamento-m5000)>250)and((abs(fechamento[1]-m110[1]))<(abs(fechamento-m110)))and(abs(fechamento-mm)>150)and(abs(vHMA-vHMA[14])<300)and(abs(m17-m17[14])<300)and(abs(mmd-mmd[14])<300)and(abs(m110-m110[14])<300)and(abertura>fechamento);  //distancia da m110
  sinalV1 :=(abs(fechamento-m5000)>250)and((abs(fechamento[1]-m110[1]))>(abs(fechamento-m110)))and(abs(fechamento-mm)>150)and(abs(vHMA-vHMA[14])<300)and(abs(m17-m17[14])<300)and(abs(mmd-mmd[14])<300)and(abs(m110-m110[14])<300)and(abertura>fechamento); //aproxima da m110

   //if not HasPosition and sinalC or sinalV or sinalC1 or sinalV1 then
   //PlotText(": "+abs(fechamento-m110),rgb(216,191,216),2,20);
                                                       
   if not HasPosition then                  
    begin
       if (zTF_IFRxPreco(4,4)|2|=1)then 
      begin 
       sinalzTFC:=true;
       sinalzTFV:=false;
      end;

       if (zTF_IFRxPreco(4,4)|1|=1)then
      begin
       sinalzTFV:=true;
       sinalzTFC:=false;
      end; 
         
     // Abrir Posicao Compra
     if (sinalC or sinalC1) and (time>=(Inicio_das_Ordens_HHMM))and(time<=(Fim_das_Entradas_HHMM)) then   //sinalzTFC and
      begin
       PaintBar(rgb(127,255,212));//aqua marine
       ultcompra:=fechamento;
       //PlotText("Compra: "+LoteInicial_8+" - Preço="+MyPrice,rgb(127,255,212),2,10);
       BuyAtMarket(LoteInicial_8);
       //if sinalC then
       //sinalzTFC:=false;
      end;
 
            
     // Abrir Posicao Venda
     if (sinalV or sinalV1) and (time>=(Inicio_das_Ordens_HHMM))and(time<=(Fim_das_Entradas_HHMM))then   // sinalzTFV and  
      begin
       PaintBar(rgb(216,191,216));//Thistle
       ultvenda:=fechamento;
       //PlotText("Venda: "+LoteInicial_8+" - Preço="+MyPrice,rgb(216,191,216),2,10);
       SellShortAtMarket(LoteInicial_8);
       //if sinalV then
       //sinalzTFV:=false;
      end;
    end;

//////////////////////////////////////////////////SAÍDAS/////////////////////////////////////////////////
                       //////////////////////Saída p/ Comprado///////////////////

   if IsBought then
    begin
     // Fechar Compra(Fechar p/ Gain)
     if time>=(FechamentoGeral_HHMM)then
      begin
       PaintBar(clVerde);
       ClosePosition;
      end
     
     else if (fechamento<fechamento[1])and(fechamento[1]<fechamento[2])and(fechamento[2]<fechamento[3])then
      begin
       PaintBar(clVerde);
       PlotText("SC1",clbranco,2,10);//PlotText("SC1: "+buyPosition+" - Preço="+MyPrice,clbranco,2,10);
       ClosePosition;
      end     
     
     else if (fechamento<=buyprice) then //((vHMA-fechamento)>100) and (fechamento<mm) and (fechamento<m17) 
      begin
       PaintBar(clVerde);
       PlotText("SC2",clbranco,2,10); //PlotText("SC2: "+buyPosition+" - Preço="+MyPrice,clbranco,2,10);
       ClosePosition;
      end
           
     //else if ((mm[1]>mm17[1])and(mm<mm17)) then     
      //begin
       //PaintBar(clVerde);
       //PlotText("SC3: "+buyPosition+" - Preço="+MyPrice,clbranco,2,10);
       //ClosePosition;
      //end

     //else if (fechamento<=buyprice)and(fechamento<fechamento[1])and(fechamento[1]<fechamento[2])then
      //begin
       //PaintBar(clVerde);
       //PlotText("SC4: "+buyPosition+" - Preço="+MyPrice,clbranco,2,10);
       //ClosePosition;
      //end

                       ////////////////////Parcial p/ Comprado///////////////////

     // Fechar Parcial Compra
     //else if (fechamento<fechamento[1])then 
      //begin
       //PaintBar(clPrata);
       //PlotText("PC1",clbranco,2,10);//PlotText("PC1: "+round(buyposition*(0.5))+" - Preço="+MyPrice,clbranco,2,10);
       //SellShortAtMarket(round(buyposition*(0.5)));  
      //end

     else if ((fechamento[1]<=m110)and(fechamento>=m110))or((fechamento[1]<=mm200)and(fechamento>=mm200))or((fechamento[1]<=m750)and(fechamento>=m750))then
      begin           
       PaintBar(clBranco);
       PlotText("PC2",clbranco,2,10);//PlotText("PC2: "+round(buyposition*(0.5))+" - Preço="+MyPrice,clbranco,2,10);
       SellShortAtMarket(round(buyposition*(0.5)));
      end

     else if (fechamento>fechamento[1])and(fechamento[1]>fechamento[2])and(fechamento[2]>fechamento[3])and(buyposition>=5)and((fechamento-buyprice)>150)then
      begin
       PaintBar(clBranco);
       PlotText("PC3",clbranco,2,10);//PlotText("PV2: "+round(sellposition*(0.5))+" - Preço="+MyPrice,clbranco,2,10);
       SellShortAtMarket(round(buyposition*(0.7)));
      end;

     // Fechar Parcial Compra(Preço próximo)
     //else if (fechamento<=fechamento[2])and(fechamento>buyprice)and(fechamento>mm)and(buyposition>=3)then
      //begin           
       //PaintBar(clCinza);
       //PlotText("PC3: "+round(buyposition*(0.7))+" - Preço="+MyPrice,clbranco,2,10);
       //SellShortAtMarket(round(buyposition*(0.7)));//SellShortAtMarket(round(buyposition*abs((buyprice - mmd)/(Fechamento-mmd))));
      //end

    end;

                        /////////////////////Saída p/ Vendido///////////////////

   if IsSold then
    begin
     // Fechar Venda(Fechar p/ Gain)
     if time>=(FechamentoGeral_HHMM)then
      begin
       PaintBar(clFucsia);
       ClosePosition;
      end
      
     else if (fechamento>fechamento[1])and(fechamento[1]>fechamento[2])and(fechamento[2]>fechamento[3])then
      begin
       PaintBar(clFucsia);
       PlotText("SV1",clbranco,2,10);//PlotText("SV1: "+sellPosition+" - Preço="+MyPrice,clbranco,2,10);
       ClosePosition;
      end 
    
     else if (fechamento>=sellprice) then //((fechamento-vHMA)>100)and(fechamento>mm)and(fechamento>m17)
      begin
       PaintBar(clFucsia);
       PlotText("SV2",clbranco,2,10);//PlotText("SV2: "+sellPosition+" - Preço="+MyPrice,clbranco,2,10);
       ClosePosition;
      end
        
     //else if ((mm[1]<mm17[1])and(mm>mm17)) then
      //begin
       //PaintBar(clFucsia);
       //PlotText("SV3: "+sellPosition+" - Preço="+MyPrice,clbranco,2,10);
       //ClosePosition;
      //end

     //else if (fechamento>=sellprice)and(fechamento>fechamento[1])and(fechamento[1]>fechamento[2])then
      //begin
       //PaintBar(clFucsia);
       //PlotText("SV4: "+sellPosition+" - Preço="+MyPrice,clbranco,2,10);
       //ClosePosition;
      //end

                       ////////////////////Parcial p/ Vendido////////////////////

     // Fechar Parcial Venda
     //else if (fechamento>fechamento[1])then 
      //begin
       //PaintBar(clPrata);
       //PlotText("PV1",clbranco,2,10);//PlotText("PV1: "+round(sellposition*(0.5)) + " - Preço=" + MyPrice,clbranco,2,10);
       //BuyAtMarket(round(sellposition*(0.5)));
      //end

     else if ((fechamento[1]>=m110)and(fechamento<=m110))or((fechamento[1]>=mm200)and(fechamento<=mm200))or((fechamento[1]>=m750)and(fechamento<=m750))and(sellposition>=3)then
      begin
       PaintBar(clBranco);
       PlotText("PV2",clbranco,2,10);//PlotText("PV2: "+round(sellposition*(0.5))+" - Preço="+MyPrice,clbranco,2,10);
       BuyAtMarket(round(sellposition*(0.5)));
      end

     else if (fechamento<fechamento[1])and(fechamento[1]<fechamento[2])and(fechamento[2]<fechamento[3])and(sellposition>=5)and((SellPrice-fechamento)>150)then
      begin
       PaintBar(clBranco);
       PlotText("PV3",clbranco,2,10);//PlotText("PV2: "+round(sellposition*(0.5))+" - Preço="+MyPrice,clbranco,2,10);
       BuyAtMarket(round(sellposition*(0.7)));
      end;

     // Fechar Parcial Venda(Preço próximo) 
     //else if (fechamento>=fechamento[2])and(fechamento<sellprice)and(fechamento<mm)and(sellposition>=3)then
      //begin
       //PaintBar(clCinza);
       //PlotText("PV2: "+round(sellposition*(0.7))+" - Preço="+MyPrice,clbranco,2,10);
       //BuyAtMarket(round(sellposition*(0.7)));//BuyAtMarket(round(sellposition*abs((mmd - sellprice)/(mmd-Fechamento))));
      //end
    end;


             ///////////////////////////////////RENTRADAS//////////////////////////////////            
   if IsBought then
    begin     
     //Recompra
     if (fechamento[1]<fechamento)and(time<=(Fim_das_Entradas_HHMM))then  //(mm>mm17)and(mm>mmd)and((fechamento-buyprice)>=150)
      begin
      if (fechamento>ultcompra)then
       begin
       //PlotText("REC: "+LoteReinicial_2+" - Preço="+MyPrice,clamarelo,1,10);
       ultcompra:=fechamento;
       BuyAtMarket(LoteReinicial_2);
       end; 
      end;
    end;
    
   if IsSold then
    begin
     //Revenda
     if (fechamento[1]>fechamento)and(time<=(Fim_das_Entradas_HHMM))then  //(mm<mm17)and(mm<mmd)  and((sellprice-fechamento)>=150)
      begin
      if (fechamento<ultvenda)then
       begin
       ultvenda:=fechamento;
       SellShortAtMarket(LoteReinicial_2);
       //PlotText("REV: "+sellposition+   " - Preço="+MyPrice,clamarelo,1,10);
       end;
      end;      
    end;
end;