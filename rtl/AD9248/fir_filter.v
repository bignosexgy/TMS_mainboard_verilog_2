// megafunction wizard: %FIR II v15.0%
// GENERATION: XML
// fir_filter.v

// Generated using ACDS version 15.0 145

`timescale 1 ps / 1 ps
module fir_filter (
		input  wire        clk,              //                     clk.clk
		input  wire        reset_n,          //                     rst.reset_n
		input  wire [13:0] ast_sink_data,    //   avalon_streaming_sink.data
		input  wire        ast_sink_valid,   //                        .valid
		input  wire [1:0]  ast_sink_error,   //                        .error
		output wire [35:0] ast_source_data,  // avalon_streaming_source.data
		output wire        ast_source_valid, //                        .valid
		output wire [1:0]  ast_source_error  //                        .error
	);

	fir_filter_0002 fir_filter_inst (
		.clk              (clk),              //                     clk.clk
		.reset_n          (reset_n),          //                     rst.reset_n
		.ast_sink_data    (ast_sink_data),    //   avalon_streaming_sink.data
		.ast_sink_valid   (ast_sink_valid),   //                        .valid
		.ast_sink_error   (ast_sink_error),   //                        .error
		.ast_source_data  (ast_source_data),  // avalon_streaming_source.data
		.ast_source_valid (ast_source_valid), //                        .valid
		.ast_source_error (ast_source_error)  //                        .error
	);

endmodule
// Retrieval info: <?xml version="1.0"?>
//<!--
//	Generated by Altera MegaWizard Launcher Utility version 1.0
//	************************************************************
//	THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//	************************************************************
//	Copyright (C) 1991-2024 Altera Corporation
//	Any megafunction design, and related net list (encrypted or decrypted),
//	support information, device programming or simulation file, and any other
//	associated documentation or information provided by Altera or a partner
//	under Altera's Megafunction Partnership Program may be used only to
//	program PLD devices (but not masked PLD devices) from Altera.  Any other
//	use of such megafunction design, net list, support information, device
//	programming or simulation file, or any other related documentation or
//	information is prohibited for any other purpose, including, but not
//	limited to modification, reverse engineering, de-compiling, or use with
//	any other silicon devices, unless such use is explicitly licensed under
//	a separate agreement with Altera or a megafunction partner.  Title to
//	the intellectual property, including patents, copyrights, trademarks,
//	trade secrets, or maskworks, embodied in any such megafunction design,
//	net list, support information, device programming or simulation file, or
//	any other related documentation or information provided by Altera or a
//	megafunction partner, remains with Altera, the megafunction partner, or
//	their respective licensors.  No other licenses, including any licenses
//	needed under any third party's intellectual property, are provided herein.
//-->
// Retrieval info: <instance entity-name="altera_fir_compiler_ii" version="15.0" >
// Retrieval info: 	<generic name="filterType" value="single" />
// Retrieval info: 	<generic name="interpFactor" value="1" />
// Retrieval info: 	<generic name="decimFactor" value="1" />
// Retrieval info: 	<generic name="symmetryMode" value="nsym" />
// Retrieval info: 	<generic name="L_bandsFilter" value="1" />
// Retrieval info: 	<generic name="inputChannelNum" value="1" />
// Retrieval info: 	<generic name="clockRate" value="65" />
// Retrieval info: 	<generic name="clockSlack" value="0" />
// Retrieval info: 	<generic name="inputRate" value="65" />
// Retrieval info: 	<generic name="coeffReload" value="false" />
// Retrieval info: 	<generic name="baseAddress" value="0" />
// Retrieval info: 	<generic name="readWriteMode" value="read_write" />
// Retrieval info: 	<generic name="backPressure" value="false" />
// Retrieval info: 	<generic name="deviceFamily" value="Cyclone IV E" />
// Retrieval info: 	<generic name="speedGrade" value="medium" />
// Retrieval info: 	<generic name="delayRAMBlockThreshold" value="20" />
// Retrieval info: 	<generic name="dualMemDistRAMThreshold" value="1280" />
// Retrieval info: 	<generic name="mRAMThreshold" value="1000000" />
// Retrieval info: 	<generic name="hardMultiplierThreshold" value="-1" />
// Retrieval info: 	<generic name="inputType" value="int" />
// Retrieval info: 	<generic name="inputBitWidth" value="14" />
// Retrieval info: 	<generic name="inputFracBitWidth" value="0" />
// Retrieval info: 	<generic name="coeffSetRealValue" value="-6.75201416015625E-4,-4.119873046875E-4,-1.41143798828125E-4,1.41143798828125E-4,4.2724609375E-4,7.171630859375E-4,0.00100326538085938,0.00128936767578125,0.0015716552734375,0.00184249877929688,0.002105712890625,0.00235366821289063,0.00258636474609375,0.00279998779296875,0.00299072265625,0.00316238403320313,0.00330352783203125,0.00341796875,0.00350570678710938,0.00356292724609375,0.0035858154296875,0.00357437133789063,0.00352859497070313,0.003448486328125,0.00333404541015625,0.00318527221679688,0.00299835205078125,0.00278091430664063,0.00252914428710938,0.00224685668945313,0.00193405151367188,0.00159454345703125,0.00122833251953125,8.392333984375E-4,4.2724609375E-4,0.0,-4.425048828125E-4,-8.9263916015625E-4,-0.00135421752929688,-0.0018157958984375,-0.00227737426757813,-0.0027313232421875,-0.00317764282226563,-0.00360870361328125,-0.00402069091796875,-0.00441360473632813,-0.0047760009765625,-0.00510787963867188,-0.00540542602539063,-0.0056610107421875,-0.0058746337890625,-0.00603866577148438,-0.00615310668945313,-0.00621414184570313,-0.00621795654296875,-0.00616455078125,-0.00604629516601563,-0.00586700439453125,-0.00562286376953125,-0.00531005859375,-0.00493240356445313,-0.004486083984375,-0.00397109985351563,-0.00339126586914063,-0.00274658203125,-0.00203704833984375,-0.0012664794921875,-4.38690185546875E-4,4.5013427734375E-4,0.00139236450195313,0.00238418579101563,0.00342178344726563,0.00449752807617188,0.005615234375,0.00676345825195313,0.00793838500976563,0.00913238525390625,0.0103416442871094,0.0115623474121094,0.012786865234375,0.014007568359375,0.0152206420898438,0.0164146423339844,0.0175895690917969,0.01873779296875,0.0198516845703125,0.0209236145019531,0.0219497680664063,0.0229263305664063,0.0238456726074219,0.0247039794921875,0.0254936218261719,0.026214599609375,0.0268592834472656,0.0274276733398438,0.0279121398925781,0.0283126831054688,0.02862548828125,0.0288543701171875,0.0289878845214844,0.0290336608886719,0.0289878845214844,0.0288543701171875,0.02862548828125,0.0283126831054688,0.0279121398925781,0.0274276733398438,0.0268592834472656,0.026214599609375,0.0254936218261719,0.0247039794921875,0.0238456726074219,0.0229263305664063,0.0219497680664063,0.0209236145019531,0.0198516845703125,0.01873779296875,0.0175895690917969,0.0164146423339844,0.0152206420898438,0.014007568359375,0.012786865234375,0.0115623474121094,0.0103416442871094,0.00913238525390625,0.00793838500976563,0.00676345825195313,0.005615234375,0.00449752807617188,0.00342178344726563,0.00238418579101563,0.00139236450195313,4.5013427734375E-4,-4.38690185546875E-4,-0.0012664794921875,-0.00203704833984375,-0.00274658203125,-0.00339126586914063,-0.00397109985351563,-0.004486083984375,-0.00493240356445313,-0.00531005859375,-0.00562286376953125,-0.00586700439453125,-0.00604629516601563,-0.00616455078125,-0.00621795654296875,-0.00621414184570313,-0.00615310668945313,-0.00603866577148438,-0.0058746337890625,-0.0056610107421875,-0.00540542602539063,-0.00510787963867188,-0.0047760009765625,-0.00441360473632813,-0.00402069091796875,-0.00360870361328125,-0.00317764282226563,-0.0027313232421875,-0.00227737426757813,-0.0018157958984375,-0.00135421752929688,-8.9263916015625E-4,-4.425048828125E-4,0.0,4.2724609375E-4,8.392333984375E-4,0.00122833251953125,0.00159454345703125,0.00193405151367188,0.00224685668945313,0.00252914428710938,0.00278091430664063,0.00299835205078125,0.00318527221679688,0.00333404541015625,0.003448486328125,0.00352859497070313,0.00357437133789063,0.0035858154296875,0.00356292724609375,0.00350570678710938,0.00341796875,0.00330352783203125,0.00316238403320313,0.00299072265625,0.00279998779296875,0.00258636474609375,0.00235366821289063,0.002105712890625,0.00184249877929688,0.0015716552734375,0.00128936767578125,0.00100326538085938,7.171630859375E-4,4.2724609375E-4,1.41143798828125E-4,-1.41143798828125E-4,-4.119873046875E-4,-6.75201416015625E-4" />
// Retrieval info: 	<generic name="coeffScaling" value="auto" />
// Retrieval info: 	<generic name="coeffType" value="int" />
// Retrieval info: 	<generic name="coeffBitWidth" value="14" />
// Retrieval info: 	<generic name="coeffFracBitWidth" value="0" />
// Retrieval info: 	<generic name="outType" value="int" />
// Retrieval info: 	<generic name="outMSBRound" value="trunc" />
// Retrieval info: 	<generic name="outMsbBitRem" value="0" />
// Retrieval info: 	<generic name="outLSBRound" value="trunc" />
// Retrieval info: 	<generic name="outLsbBitRem" value="0" />
// Retrieval info: 	<generic name="bankCount" value="1" />
// Retrieval info: 	<generic name="bankDisplay" value="0" />
// Retrieval info: </instance>
// IPFS_FILES : fir_filter.vo
// RELATED_FILES: fir_filter.v, dspba_library_package.vhd, dspba_library.vhd, auk_dspip_math_pkg_hpfir.vhd, auk_dspip_lib_pkg_hpfir.vhd, auk_dspip_avalon_streaming_controller_hpfir.vhd, auk_dspip_avalon_streaming_sink_hpfir.vhd, auk_dspip_avalon_streaming_source_hpfir.vhd, auk_dspip_roundsat_hpfir.vhd, altera_avalon_sc_fifo.v, fir_filter_0002_rtl.vhd, fir_filter_0002_ast.vhd, fir_filter_0002.vhd