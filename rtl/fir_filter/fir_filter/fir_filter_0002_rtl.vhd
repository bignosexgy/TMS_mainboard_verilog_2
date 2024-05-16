-- ------------------------------------------------------------------------- 
-- Altera DSP Builder Advanced Flow Tools Release Version 15.0
-- Quartus II development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2015 Altera Corporation.  All rights reserved.
-- Your use of  Altera  Corporation's design tools,  logic functions and other
-- software and tools,  and its AMPP  partner logic functions, and  any output
-- files  any of the  foregoing  device programming or simulation files),  and
-- any associated  documentation or information are expressly subject  to  the
-- terms and conditions  of the Altera Program License Subscription Agreement,
-- Altera  MegaCore  Function  License  Agreement, or other applicable license
-- agreement,  including,  without limitation,  that your use  is for the sole
-- purpose of  programming  logic  devices  manufactured by Altera and sold by
-- Altera or its authorized  distributors.  Please  refer  to  the  applicable
-- agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from fir_filter_0002_rtl
-- VHDL created on Sat May 11 13:48:35 2024


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY lpm;
USE lpm.lpm_components.all;

entity fir_filter_0002_rtl is
    port (
        xIn_v : in std_logic_vector(0 downto 0);  -- sfix1
        xIn_c : in std_logic_vector(7 downto 0);  -- sfix8
        xIn_0 : in std_logic_vector(13 downto 0);  -- sfix14
        xOut_v : out std_logic_vector(0 downto 0);  -- ufix1
        xOut_c : out std_logic_vector(7 downto 0);  -- ufix8
        xOut_0 : out std_logic_vector(32 downto 0);  -- sfix33
        clk : in std_logic;
        areset : in std_logic
    );
end fir_filter_0002_rtl;

architecture normal of fir_filter_0002_rtl is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_compute_q_16_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_wi0_phasedelay0_q_11_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr1_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr2_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr3_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr4_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr5_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr6_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr7_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr8_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr9_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr10_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr11_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr12_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr13_q : STD_LOGIC_VECTOR (13 downto 0);
    signal d_u0_m0_wo0_wi0_delayr13_q_11_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr14_q : STD_LOGIC_VECTOR (13 downto 0);
    signal d_u0_m0_wo0_wi0_delayr14_q_11_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr15_q : STD_LOGIC_VECTOR (13 downto 0);
    signal d_u0_m0_wo0_wi0_delayr15_q_11_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr16_q : STD_LOGIC_VECTOR (13 downto 0);
    signal d_u0_m0_wo0_wi0_delayr16_q_11_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr17_q : STD_LOGIC_VECTOR (13 downto 0);
    signal d_u0_m0_wo0_wi0_delayr17_q_11_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr18_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr19_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr20_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr21_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr22_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr23_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr24_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr25_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr26_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr27_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr28_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr29_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_delayr30_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_cm0_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_cm1_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_cm2_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_cm3_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_cm4_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_cm5_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_cm7_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_cm8_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_cm10_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_30_a0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_30_b0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_30_s1 : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_30_reset : std_logic;
    signal u0_m0_wo0_mtree_mult1_30_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_29_a0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_29_b0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_29_s1 : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_29_reset : std_logic;
    signal u0_m0_wo0_mtree_mult1_29_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_28_a0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_28_b0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_28_s1 : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_28_reset : std_logic;
    signal u0_m0_wo0_mtree_mult1_28_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_27_a0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_27_b0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_27_s1 : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_27_reset : std_logic;
    signal u0_m0_wo0_mtree_mult1_27_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_26_a0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_26_b0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_26_s1 : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_26_reset : std_logic;
    signal u0_m0_wo0_mtree_mult1_26_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_25_a0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_25_b0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_25_s1 : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_25_reset : std_logic;
    signal u0_m0_wo0_mtree_mult1_25_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_23_a0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_23_b0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_23_s1 : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_23_reset : std_logic;
    signal u0_m0_wo0_mtree_mult1_23_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_22_a0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_22_b0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_22_s1 : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_22_reset : std_logic;
    signal u0_m0_wo0_mtree_mult1_22_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_20_a0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_20_b0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_20_s1 : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_20_reset : std_logic;
    signal u0_m0_wo0_mtree_mult1_20_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_10_a0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_10_b0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_10_s1 : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_10_reset : std_logic;
    signal u0_m0_wo0_mtree_mult1_10_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_8_a0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_8_b0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_8_s1 : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_8_reset : std_logic;
    signal u0_m0_wo0_mtree_mult1_8_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_7_a0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_7_b0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_7_s1 : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_7_reset : std_logic;
    signal u0_m0_wo0_mtree_mult1_7_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_5_a0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_5_b0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_5_s1 : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_5_reset : std_logic;
    signal u0_m0_wo0_mtree_mult1_5_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_4_a0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_4_b0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_4_s1 : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_4_reset : std_logic;
    signal u0_m0_wo0_mtree_mult1_4_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_3_a0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_3_b0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_3_s1 : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_3_reset : std_logic;
    signal u0_m0_wo0_mtree_mult1_3_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_2_a0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_2_b0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_2_s1 : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_2_reset : std_logic;
    signal u0_m0_wo0_mtree_mult1_2_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_1_a0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_1_b0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_1_s1 : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_1_reset : std_logic;
    signal u0_m0_wo0_mtree_mult1_1_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_a0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_b0 : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_s1 : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_reset : std_logic;
    signal u0_m0_wo0_mtree_mult1_0_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_add0_0_a : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_0_b : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_0_o : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_0_q : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_1_a : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_1_b : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_1_o : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_1_q : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_2_a : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_2_b : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_2_o : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_2_q : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_3_a : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_3_b : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_3_o : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_3_q : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_4_a : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_4_b : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_4_o : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_4_q : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_5_a : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_5_b : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_5_o : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_5_q : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_6_a : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_6_b : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_6_o : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_6_q : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_7_a : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_7_b : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_7_o : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_7_q : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_8_a : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_8_b : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_8_o : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_8_q : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_9_a : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_9_b : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_9_o : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_9_q : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_10_a : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_10_b : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_10_o : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_10_q : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_11_a : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_11_b : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_11_o : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_11_q : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_12_a : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_12_b : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_12_o : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_12_q : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_13_a : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_13_b : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_13_o : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_13_q : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_14_a : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_14_b : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_14_o : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add0_14_q : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add1_0_a : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_0_b : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_0_o : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_0_q : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_1_a : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_1_b : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_1_o : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_1_q : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_2_a : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_2_b : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_2_o : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_2_q : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_3_a : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_3_b : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_3_o : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_3_q : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_4_a : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_4_b : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_4_o : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_4_q : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_5_a : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_5_b : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_5_o : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_5_q : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_6_a : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_6_b : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_6_o : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_6_q : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_7_a : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_7_b : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_7_o : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add1_7_q : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add2_0_a : STD_LOGIC_VECTOR (30 downto 0);
    signal u0_m0_wo0_mtree_add2_0_b : STD_LOGIC_VECTOR (30 downto 0);
    signal u0_m0_wo0_mtree_add2_0_o : STD_LOGIC_VECTOR (30 downto 0);
    signal u0_m0_wo0_mtree_add2_0_q : STD_LOGIC_VECTOR (30 downto 0);
    signal u0_m0_wo0_mtree_add2_1_a : STD_LOGIC_VECTOR (30 downto 0);
    signal u0_m0_wo0_mtree_add2_1_b : STD_LOGIC_VECTOR (30 downto 0);
    signal u0_m0_wo0_mtree_add2_1_o : STD_LOGIC_VECTOR (30 downto 0);
    signal u0_m0_wo0_mtree_add2_1_q : STD_LOGIC_VECTOR (30 downto 0);
    signal u0_m0_wo0_mtree_add2_2_a : STD_LOGIC_VECTOR (30 downto 0);
    signal u0_m0_wo0_mtree_add2_2_b : STD_LOGIC_VECTOR (30 downto 0);
    signal u0_m0_wo0_mtree_add2_2_o : STD_LOGIC_VECTOR (30 downto 0);
    signal u0_m0_wo0_mtree_add2_2_q : STD_LOGIC_VECTOR (30 downto 0);
    signal u0_m0_wo0_mtree_add2_3_a : STD_LOGIC_VECTOR (30 downto 0);
    signal u0_m0_wo0_mtree_add2_3_b : STD_LOGIC_VECTOR (30 downto 0);
    signal u0_m0_wo0_mtree_add2_3_o : STD_LOGIC_VECTOR (30 downto 0);
    signal u0_m0_wo0_mtree_add2_3_q : STD_LOGIC_VECTOR (30 downto 0);
    signal u0_m0_wo0_mtree_add3_0_a : STD_LOGIC_VECTOR (31 downto 0);
    signal u0_m0_wo0_mtree_add3_0_b : STD_LOGIC_VECTOR (31 downto 0);
    signal u0_m0_wo0_mtree_add3_0_o : STD_LOGIC_VECTOR (31 downto 0);
    signal u0_m0_wo0_mtree_add3_0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal u0_m0_wo0_mtree_add3_1_a : STD_LOGIC_VECTOR (31 downto 0);
    signal u0_m0_wo0_mtree_add3_1_b : STD_LOGIC_VECTOR (31 downto 0);
    signal u0_m0_wo0_mtree_add3_1_o : STD_LOGIC_VECTOR (31 downto 0);
    signal u0_m0_wo0_mtree_add3_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal u0_m0_wo0_mtree_add4_0_a : STD_LOGIC_VECTOR (32 downto 0);
    signal u0_m0_wo0_mtree_add4_0_b : STD_LOGIC_VECTOR (32 downto 0);
    signal u0_m0_wo0_mtree_add4_0_o : STD_LOGIC_VECTOR (32 downto 0);
    signal u0_m0_wo0_mtree_add4_0_q : STD_LOGIC_VECTOR (32 downto 0);
    signal u0_m0_wo0_oseq_gated_reg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_mtree_mult1_24_sub_1_a : STD_LOGIC_VECTOR (21 downto 0);
    signal u0_m0_wo0_mtree_mult1_24_sub_1_b : STD_LOGIC_VECTOR (21 downto 0);
    signal u0_m0_wo0_mtree_mult1_24_sub_1_o : STD_LOGIC_VECTOR (21 downto 0);
    signal u0_m0_wo0_mtree_mult1_24_sub_1_q : STD_LOGIC_VECTOR (21 downto 0);
    signal u0_m0_wo0_mtree_mult1_24_sub_3_a : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_24_sub_3_b : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_24_sub_3_o : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_24_sub_3_q : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_24_add_5_a : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_mult1_24_add_5_b : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_mult1_24_add_5_o : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_mult1_24_add_5_q : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_mult1_21_sub_1_a : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_21_sub_1_b : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_21_sub_1_o : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_21_sub_1_q : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_21_sub_3_a : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_21_sub_3_b : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_21_sub_3_o : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_21_sub_3_q : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_21_add_5_a : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_mult1_21_add_5_b : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_mult1_21_add_5_o : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_mult1_21_add_5_q : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_mult1_19_add_1_a : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_19_add_1_b : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_19_add_1_o : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_19_add_1_q : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_19_sub_3_a : STD_LOGIC_VECTOR (19 downto 0);
    signal u0_m0_wo0_mtree_mult1_19_sub_3_b : STD_LOGIC_VECTOR (19 downto 0);
    signal u0_m0_wo0_mtree_mult1_19_sub_3_o : STD_LOGIC_VECTOR (19 downto 0);
    signal u0_m0_wo0_mtree_mult1_19_sub_3_q : STD_LOGIC_VECTOR (19 downto 0);
    signal u0_m0_wo0_mtree_mult1_19_add_5_a : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_19_add_5_b : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_19_add_5_o : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_19_add_5_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_18_sub_1_a : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_mtree_mult1_18_sub_1_b : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_mtree_mult1_18_sub_1_o : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_mtree_mult1_18_sub_1_q : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_mtree_mult1_18_sub_3_a : STD_LOGIC_VECTOR (20 downto 0);
    signal u0_m0_wo0_mtree_mult1_18_sub_3_b : STD_LOGIC_VECTOR (20 downto 0);
    signal u0_m0_wo0_mtree_mult1_18_sub_3_o : STD_LOGIC_VECTOR (20 downto 0);
    signal u0_m0_wo0_mtree_mult1_18_sub_3_q : STD_LOGIC_VECTOR (20 downto 0);
    signal u0_m0_wo0_mtree_mult1_18_add_5_a : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_18_add_5_b : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_18_add_5_o : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_18_add_5_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_17_sub_1_a : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_17_sub_1_b : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_17_sub_1_o : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_17_sub_1_q : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_17_add_3_a : STD_LOGIC_VECTOR (25 downto 0);
    signal u0_m0_wo0_mtree_mult1_17_add_3_b : STD_LOGIC_VECTOR (25 downto 0);
    signal u0_m0_wo0_mtree_mult1_17_add_3_o : STD_LOGIC_VECTOR (25 downto 0);
    signal u0_m0_wo0_mtree_mult1_17_add_3_q : STD_LOGIC_VECTOR (25 downto 0);
    signal u0_m0_wo0_mtree_mult1_16_add_1_a : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_16_add_1_b : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_16_add_1_o : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_16_add_1_q : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_16_sub_3_a : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_16_sub_3_b : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_16_sub_3_o : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_16_sub_3_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_15_sub_1_a : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_15_sub_1_b : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_15_sub_1_o : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_15_sub_1_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_14_add_1_a : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_14_add_1_b : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_14_add_1_o : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_14_add_1_q : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_14_sub_3_a : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_14_sub_3_b : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_14_sub_3_o : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_14_sub_3_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_13_sub_1_a : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_13_sub_1_b : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_13_sub_1_o : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_13_sub_1_q : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_13_add_3_a : STD_LOGIC_VECTOR (25 downto 0);
    signal u0_m0_wo0_mtree_mult1_13_add_3_b : STD_LOGIC_VECTOR (25 downto 0);
    signal u0_m0_wo0_mtree_mult1_13_add_3_o : STD_LOGIC_VECTOR (25 downto 0);
    signal u0_m0_wo0_mtree_mult1_13_add_3_q : STD_LOGIC_VECTOR (25 downto 0);
    signal u0_m0_wo0_mtree_mult1_12_sub_1_a : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_mtree_mult1_12_sub_1_b : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_mtree_mult1_12_sub_1_o : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_mtree_mult1_12_sub_1_q : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_mtree_mult1_12_sub_3_a : STD_LOGIC_VECTOR (20 downto 0);
    signal u0_m0_wo0_mtree_mult1_12_sub_3_b : STD_LOGIC_VECTOR (20 downto 0);
    signal u0_m0_wo0_mtree_mult1_12_sub_3_o : STD_LOGIC_VECTOR (20 downto 0);
    signal u0_m0_wo0_mtree_mult1_12_sub_3_q : STD_LOGIC_VECTOR (20 downto 0);
    signal u0_m0_wo0_mtree_mult1_12_add_5_a : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_12_add_5_b : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_12_add_5_o : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_12_add_5_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_11_add_1_a : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_11_add_1_b : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_11_add_1_o : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_11_add_1_q : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_11_sub_3_a : STD_LOGIC_VECTOR (19 downto 0);
    signal u0_m0_wo0_mtree_mult1_11_sub_3_b : STD_LOGIC_VECTOR (19 downto 0);
    signal u0_m0_wo0_mtree_mult1_11_sub_3_o : STD_LOGIC_VECTOR (19 downto 0);
    signal u0_m0_wo0_mtree_mult1_11_sub_3_q : STD_LOGIC_VECTOR (19 downto 0);
    signal u0_m0_wo0_mtree_mult1_11_add_5_a : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_11_add_5_b : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_11_add_5_o : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_11_add_5_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_9_sub_1_a : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_9_sub_1_b : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_9_sub_1_o : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_9_sub_1_q : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_9_sub_3_a : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_9_sub_3_b : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_9_sub_3_o : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_9_sub_3_q : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_9_add_5_a : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_mult1_9_add_5_b : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_mult1_9_add_5_o : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_mult1_9_add_5_q : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_mult1_6_sub_1_a : STD_LOGIC_VECTOR (21 downto 0);
    signal u0_m0_wo0_mtree_mult1_6_sub_1_b : STD_LOGIC_VECTOR (21 downto 0);
    signal u0_m0_wo0_mtree_mult1_6_sub_1_o : STD_LOGIC_VECTOR (21 downto 0);
    signal u0_m0_wo0_mtree_mult1_6_sub_1_q : STD_LOGIC_VECTOR (21 downto 0);
    signal u0_m0_wo0_mtree_mult1_6_sub_3_a : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_6_sub_3_b : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_6_sub_3_o : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_6_sub_3_q : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_6_add_5_a : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_mult1_6_add_5_b : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_mult1_6_add_5_o : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_mult1_6_add_5_q : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_mult1_24_shift0_q : STD_LOGIC_VECTOR (20 downto 0);
    signal u0_m0_wo0_mtree_mult1_24_shift0_q_int : STD_LOGIC_VECTOR (20 downto 0);
    signal u0_m0_wo0_mtree_mult1_24_shift2_q : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_mtree_mult1_24_shift2_q_int : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_mtree_mult1_21_shift0_q : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_21_shift0_q_int : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_21_shift2_q : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_21_shift2_q_int : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_19_shift0_q : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_mtree_mult1_19_shift0_q_int : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_mtree_mult1_19_shift2_q : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_19_shift2_q_int : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_18_shift0_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_mtree_mult1_18_shift0_q_int : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_mtree_mult1_18_shift2_q : STD_LOGIC_VECTOR (19 downto 0);
    signal u0_m0_wo0_mtree_mult1_18_shift2_q_int : STD_LOGIC_VECTOR (19 downto 0);
    signal u0_m0_wo0_mtree_mult1_17_shift0_q : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_17_shift0_q_int : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_17_shift2_q : STD_LOGIC_VECTOR (24 downto 0);
    signal u0_m0_wo0_mtree_mult1_17_shift2_q_int : STD_LOGIC_VECTOR (24 downto 0);
    signal u0_m0_wo0_mtree_mult1_16_shift0_q : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_16_shift0_q_int : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_16_shift2_q : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_mult1_16_shift2_q_int : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_mult1_15_shift0_q : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_mult1_15_shift0_q_int : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_mult1_14_shift0_q : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_14_shift0_q_int : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_14_shift2_q : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_mult1_14_shift2_q_int : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_mult1_13_shift0_q : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_13_shift0_q_int : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_13_shift2_q : STD_LOGIC_VECTOR (24 downto 0);
    signal u0_m0_wo0_mtree_mult1_13_shift2_q_int : STD_LOGIC_VECTOR (24 downto 0);
    signal u0_m0_wo0_mtree_mult1_12_shift0_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_mtree_mult1_12_shift0_q_int : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_mtree_mult1_12_shift2_q : STD_LOGIC_VECTOR (19 downto 0);
    signal u0_m0_wo0_mtree_mult1_12_shift2_q_int : STD_LOGIC_VECTOR (19 downto 0);
    signal u0_m0_wo0_mtree_mult1_11_shift0_q : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_mtree_mult1_11_shift0_q_int : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_mtree_mult1_11_shift2_q : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_11_shift2_q_int : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_m0_wo0_mtree_mult1_9_shift0_q : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_9_shift0_q_int : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_9_shift2_q : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_9_shift2_q_int : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_m0_wo0_mtree_mult1_6_shift0_q : STD_LOGIC_VECTOR (20 downto 0);
    signal u0_m0_wo0_mtree_mult1_6_shift0_q_int : STD_LOGIC_VECTOR (20 downto 0);
    signal u0_m0_wo0_mtree_mult1_6_shift2_q : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_mtree_mult1_6_shift2_q_int : STD_LOGIC_VECTOR (16 downto 0);
    signal u0_m0_wo0_mtree_mult1_24_shift4_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_24_shift4_q_int : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_21_shift4_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_21_shift4_q_int : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_19_shift4_q : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_mult1_19_shift4_q_int : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_mult1_19_shift6_q : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_mult1_19_shift6_q_int : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_mult1_18_shift4_q : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_mult1_18_shift4_q_int : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_mult1_18_shift6_q : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_mult1_18_shift6_q_int : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_mult1_17_shift4_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_17_shift4_q_int : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_13_shift4_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_13_shift4_q_int : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_12_shift4_q : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_mult1_12_shift4_q_int : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_mult1_12_shift6_q : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_mult1_12_shift6_q_int : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_mult1_11_shift4_q : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_mult1_11_shift4_q_int : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_mult1_11_shift6_q : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_mult1_11_shift6_q_int : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_mult1_9_shift4_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_9_shift4_q_int : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_6_shift4_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_mult1_6_shift4_q_int : STD_LOGIC_VECTOR (27 downto 0);

begin


    -- VCC(CONSTANT,1)@0
    VCC_q <= "1";

    -- xIn(PORTIN,2)@10

    -- d_u0_m0_wo0_wi0_phasedelay0_q_11(DELAY,710)@10
    d_u0_m0_wo0_wi0_phasedelay0_q_11 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => xIn_0, xout => d_u0_m0_wo0_wi0_phasedelay0_q_11_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_cm0(CONSTANT,41)@0
    u0_m0_wo0_cm0_q <= "01010010011001";

    -- u0_m0_wo0_mtree_mult1_30(MULT,72)@11
    u0_m0_wo0_mtree_mult1_30_a0 <= STD_LOGIC_VECTOR(u0_m0_wo0_cm0_q);
    u0_m0_wo0_mtree_mult1_30_b0 <= STD_LOGIC_VECTOR(d_u0_m0_wo0_wi0_phasedelay0_q_11_q);
    u0_m0_wo0_mtree_mult1_30_reset <= areset;
    u0_m0_wo0_mtree_mult1_30_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 14,
        lpm_widthb => 14,
        lpm_widthp => 28,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "SIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => u0_m0_wo0_mtree_mult1_30_a0,
        datab => u0_m0_wo0_mtree_mult1_30_b0,
        clken => VCC_q(0),
        aclr => u0_m0_wo0_mtree_mult1_30_reset,
        clock => clk,
        result => u0_m0_wo0_mtree_mult1_30_s1
    );
    u0_m0_wo0_mtree_mult1_30_q <= u0_m0_wo0_mtree_mult1_30_s1;

    -- u0_m0_wo0_wi0_delayr1(DELAY,11)@10
    u0_m0_wo0_wi0_delayr1 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => xIn_0, xout => u0_m0_wo0_wi0_delayr1_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_cm1(CONSTANT,42)@0
    u0_m0_wo0_cm1_q <= "01010111100010";

    -- u0_m0_wo0_mtree_mult1_29(MULT,73)@10
    u0_m0_wo0_mtree_mult1_29_a0 <= STD_LOGIC_VECTOR(u0_m0_wo0_cm1_q);
    u0_m0_wo0_mtree_mult1_29_b0 <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_delayr1_q);
    u0_m0_wo0_mtree_mult1_29_reset <= areset;
    u0_m0_wo0_mtree_mult1_29_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 14,
        lpm_widthb => 14,
        lpm_widthp => 28,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "SIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => u0_m0_wo0_mtree_mult1_29_a0,
        datab => u0_m0_wo0_mtree_mult1_29_b0,
        clken => VCC_q(0),
        aclr => u0_m0_wo0_mtree_mult1_29_reset,
        clock => clk,
        result => u0_m0_wo0_mtree_mult1_29_s1
    );
    u0_m0_wo0_mtree_mult1_29_q <= u0_m0_wo0_mtree_mult1_29_s1;

    -- u0_m0_wo0_wi0_delayr2(DELAY,12)@10
    u0_m0_wo0_wi0_delayr2 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr1_q, xout => u0_m0_wo0_wi0_delayr2_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_cm2(CONSTANT,43)@0
    u0_m0_wo0_cm2_q <= "01011100100001";

    -- u0_m0_wo0_mtree_mult1_28(MULT,74)@10
    u0_m0_wo0_mtree_mult1_28_a0 <= STD_LOGIC_VECTOR(u0_m0_wo0_cm2_q);
    u0_m0_wo0_mtree_mult1_28_b0 <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_delayr2_q);
    u0_m0_wo0_mtree_mult1_28_reset <= areset;
    u0_m0_wo0_mtree_mult1_28_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 14,
        lpm_widthb => 14,
        lpm_widthp => 28,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "SIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => u0_m0_wo0_mtree_mult1_28_a0,
        datab => u0_m0_wo0_mtree_mult1_28_b0,
        clken => VCC_q(0),
        aclr => u0_m0_wo0_mtree_mult1_28_reset,
        clock => clk,
        result => u0_m0_wo0_mtree_mult1_28_s1
    );
    u0_m0_wo0_mtree_mult1_28_q <= u0_m0_wo0_mtree_mult1_28_s1;

    -- u0_m0_wo0_mtree_add0_14(ADD,117)@12
    u0_m0_wo0_mtree_add0_14_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_mult1_28_q(27)) & u0_m0_wo0_mtree_mult1_28_q));
    u0_m0_wo0_mtree_add0_14_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_mult1_29_q(27)) & u0_m0_wo0_mtree_mult1_29_q));
    u0_m0_wo0_mtree_add0_14: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add0_14_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add0_14_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add0_14_a) + SIGNED(u0_m0_wo0_mtree_add0_14_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add0_14_q <= u0_m0_wo0_mtree_add0_14_o(28 downto 0);

    -- u0_m0_wo0_mtree_add1_7(ADD,125)@13
    u0_m0_wo0_mtree_add1_7_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 29 => u0_m0_wo0_mtree_add0_14_q(28)) & u0_m0_wo0_mtree_add0_14_q));
    u0_m0_wo0_mtree_add1_7_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 28 => u0_m0_wo0_mtree_mult1_30_q(27)) & u0_m0_wo0_mtree_mult1_30_q));
    u0_m0_wo0_mtree_add1_7: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add1_7_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add1_7_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add1_7_a) + SIGNED(u0_m0_wo0_mtree_add1_7_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add1_7_q <= u0_m0_wo0_mtree_add1_7_o(29 downto 0);

    -- u0_m0_wo0_wi0_delayr3(DELAY,13)@10
    u0_m0_wo0_wi0_delayr3 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr2_q, xout => u0_m0_wo0_wi0_delayr3_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_cm3(CONSTANT,44)@0
    u0_m0_wo0_cm3_q <= "01100001010001";

    -- u0_m0_wo0_mtree_mult1_27(MULT,75)@10
    u0_m0_wo0_mtree_mult1_27_a0 <= STD_LOGIC_VECTOR(u0_m0_wo0_cm3_q);
    u0_m0_wo0_mtree_mult1_27_b0 <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_delayr3_q);
    u0_m0_wo0_mtree_mult1_27_reset <= areset;
    u0_m0_wo0_mtree_mult1_27_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 14,
        lpm_widthb => 14,
        lpm_widthp => 28,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "SIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => u0_m0_wo0_mtree_mult1_27_a0,
        datab => u0_m0_wo0_mtree_mult1_27_b0,
        clken => VCC_q(0),
        aclr => u0_m0_wo0_mtree_mult1_27_reset,
        clock => clk,
        result => u0_m0_wo0_mtree_mult1_27_s1
    );
    u0_m0_wo0_mtree_mult1_27_q <= u0_m0_wo0_mtree_mult1_27_s1;

    -- u0_m0_wo0_wi0_delayr4(DELAY,14)@10
    u0_m0_wo0_wi0_delayr4 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr3_q, xout => u0_m0_wo0_wi0_delayr4_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_cm4(CONSTANT,45)@0
    u0_m0_wo0_cm4_q <= "01100101110011";

    -- u0_m0_wo0_mtree_mult1_26(MULT,76)@10
    u0_m0_wo0_mtree_mult1_26_a0 <= STD_LOGIC_VECTOR(u0_m0_wo0_cm4_q);
    u0_m0_wo0_mtree_mult1_26_b0 <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_delayr4_q);
    u0_m0_wo0_mtree_mult1_26_reset <= areset;
    u0_m0_wo0_mtree_mult1_26_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 14,
        lpm_widthb => 14,
        lpm_widthp => 28,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "SIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => u0_m0_wo0_mtree_mult1_26_a0,
        datab => u0_m0_wo0_mtree_mult1_26_b0,
        clken => VCC_q(0),
        aclr => u0_m0_wo0_mtree_mult1_26_reset,
        clock => clk,
        result => u0_m0_wo0_mtree_mult1_26_s1
    );
    u0_m0_wo0_mtree_mult1_26_q <= u0_m0_wo0_mtree_mult1_26_s1;

    -- u0_m0_wo0_mtree_add0_13(ADD,116)@12
    u0_m0_wo0_mtree_add0_13_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_mult1_26_q(27)) & u0_m0_wo0_mtree_mult1_26_q));
    u0_m0_wo0_mtree_add0_13_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_mult1_27_q(27)) & u0_m0_wo0_mtree_mult1_27_q));
    u0_m0_wo0_mtree_add0_13: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add0_13_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add0_13_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add0_13_a) + SIGNED(u0_m0_wo0_mtree_add0_13_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add0_13_q <= u0_m0_wo0_mtree_add0_13_o(28 downto 0);

    -- u0_m0_wo0_wi0_delayr5(DELAY,15)@10
    u0_m0_wo0_wi0_delayr5 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr4_q, xout => u0_m0_wo0_wi0_delayr5_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_cm5(CONSTANT,46)@0
    u0_m0_wo0_cm5_q <= "01101010000011";

    -- u0_m0_wo0_mtree_mult1_25(MULT,77)@10
    u0_m0_wo0_mtree_mult1_25_a0 <= STD_LOGIC_VECTOR(u0_m0_wo0_cm5_q);
    u0_m0_wo0_mtree_mult1_25_b0 <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_delayr5_q);
    u0_m0_wo0_mtree_mult1_25_reset <= areset;
    u0_m0_wo0_mtree_mult1_25_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 14,
        lpm_widthb => 14,
        lpm_widthp => 28,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "SIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => u0_m0_wo0_mtree_mult1_25_a0,
        datab => u0_m0_wo0_mtree_mult1_25_b0,
        clken => VCC_q(0),
        aclr => u0_m0_wo0_mtree_mult1_25_reset,
        clock => clk,
        result => u0_m0_wo0_mtree_mult1_25_s1
    );
    u0_m0_wo0_mtree_mult1_25_q <= u0_m0_wo0_mtree_mult1_25_s1;

    -- u0_m0_wo0_wi0_delayr6(DELAY,16)@10
    u0_m0_wo0_wi0_delayr6 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr5_q, xout => u0_m0_wo0_wi0_delayr6_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_mtree_mult1_24_shift2(BITSHIFT,198)@10
    u0_m0_wo0_mtree_mult1_24_shift2_q_int <= u0_m0_wo0_wi0_delayr6_q & "000";
    u0_m0_wo0_mtree_mult1_24_shift2_q <= u0_m0_wo0_mtree_mult1_24_shift2_q_int(16 downto 0);

    -- u0_m0_wo0_mtree_mult1_24_sub_3(SUB,199)@10
    u0_m0_wo0_mtree_mult1_24_sub_3_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 17 => u0_m0_wo0_mtree_mult1_24_shift2_q(16)) & u0_m0_wo0_mtree_mult1_24_shift2_q));
    u0_m0_wo0_mtree_mult1_24_sub_3_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 14 => u0_m0_wo0_wi0_delayr6_q(13)) & u0_m0_wo0_wi0_delayr6_q));
    u0_m0_wo0_mtree_mult1_24_sub_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_24_sub_3_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_24_sub_3_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_24_sub_3_a) - SIGNED(u0_m0_wo0_mtree_mult1_24_sub_3_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_24_sub_3_q <= u0_m0_wo0_mtree_mult1_24_sub_3_o(17 downto 0);

    -- u0_m0_wo0_mtree_mult1_24_shift4(BITSHIFT,200)@11
    u0_m0_wo0_mtree_mult1_24_shift4_q_int <= u0_m0_wo0_mtree_mult1_24_sub_3_q & "0000000000";
    u0_m0_wo0_mtree_mult1_24_shift4_q <= u0_m0_wo0_mtree_mult1_24_shift4_q_int(27 downto 0);

    -- u0_m0_wo0_mtree_mult1_24_shift0(BITSHIFT,196)@10
    u0_m0_wo0_mtree_mult1_24_shift0_q_int <= u0_m0_wo0_wi0_delayr6_q & "0000000";
    u0_m0_wo0_mtree_mult1_24_shift0_q <= u0_m0_wo0_mtree_mult1_24_shift0_q_int(20 downto 0);

    -- u0_m0_wo0_mtree_mult1_24_sub_1(SUB,197)@10
    u0_m0_wo0_mtree_mult1_24_sub_1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 14 => u0_m0_wo0_wi0_delayr6_q(13)) & u0_m0_wo0_wi0_delayr6_q));
    u0_m0_wo0_mtree_mult1_24_sub_1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 21 => u0_m0_wo0_mtree_mult1_24_shift0_q(20)) & u0_m0_wo0_mtree_mult1_24_shift0_q));
    u0_m0_wo0_mtree_mult1_24_sub_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_24_sub_1_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_24_sub_1_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_24_sub_1_a) - SIGNED(u0_m0_wo0_mtree_mult1_24_sub_1_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_24_sub_1_q <= u0_m0_wo0_mtree_mult1_24_sub_1_o(21 downto 0);

    -- u0_m0_wo0_mtree_mult1_24_add_5(ADD,201)@11
    u0_m0_wo0_mtree_mult1_24_add_5_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 22 => u0_m0_wo0_mtree_mult1_24_sub_1_q(21)) & u0_m0_wo0_mtree_mult1_24_sub_1_q));
    u0_m0_wo0_mtree_mult1_24_add_5_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_mult1_24_shift4_q(27)) & u0_m0_wo0_mtree_mult1_24_shift4_q));
    u0_m0_wo0_mtree_mult1_24_add_5: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_24_add_5_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_24_add_5_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_24_add_5_a) + SIGNED(u0_m0_wo0_mtree_mult1_24_add_5_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_24_add_5_q <= u0_m0_wo0_mtree_mult1_24_add_5_o(28 downto 0);

    -- u0_m0_wo0_mtree_add0_12(ADD,115)@12
    u0_m0_wo0_mtree_add0_12_a <= STD_LOGIC_VECTOR(u0_m0_wo0_mtree_mult1_24_add_5_q);
    u0_m0_wo0_mtree_add0_12_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_mult1_25_q(27)) & u0_m0_wo0_mtree_mult1_25_q));
    u0_m0_wo0_mtree_add0_12: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add0_12_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add0_12_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add0_12_a) + SIGNED(u0_m0_wo0_mtree_add0_12_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add0_12_q <= u0_m0_wo0_mtree_add0_12_o(28 downto 0);

    -- u0_m0_wo0_mtree_add1_6(ADD,124)@13
    u0_m0_wo0_mtree_add1_6_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 29 => u0_m0_wo0_mtree_add0_12_q(28)) & u0_m0_wo0_mtree_add0_12_q));
    u0_m0_wo0_mtree_add1_6_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 29 => u0_m0_wo0_mtree_add0_13_q(28)) & u0_m0_wo0_mtree_add0_13_q));
    u0_m0_wo0_mtree_add1_6: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add1_6_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add1_6_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add1_6_a) + SIGNED(u0_m0_wo0_mtree_add1_6_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add1_6_q <= u0_m0_wo0_mtree_add1_6_o(29 downto 0);

    -- u0_m0_wo0_mtree_add2_3(ADD,129)@14
    u0_m0_wo0_mtree_add2_3_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 30 => u0_m0_wo0_mtree_add1_6_q(29)) & u0_m0_wo0_mtree_add1_6_q));
    u0_m0_wo0_mtree_add2_3_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 30 => u0_m0_wo0_mtree_add1_7_q(29)) & u0_m0_wo0_mtree_add1_7_q));
    u0_m0_wo0_mtree_add2_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add2_3_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add2_3_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add2_3_a) + SIGNED(u0_m0_wo0_mtree_add2_3_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add2_3_q <= u0_m0_wo0_mtree_add2_3_o(30 downto 0);

    -- u0_m0_wo0_wi0_delayr7(DELAY,17)@10
    u0_m0_wo0_wi0_delayr7 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr6_q, xout => u0_m0_wo0_wi0_delayr7_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_cm7(CONSTANT,48)@0
    u0_m0_wo0_cm7_q <= "01110001101000";

    -- u0_m0_wo0_mtree_mult1_23(MULT,79)@10
    u0_m0_wo0_mtree_mult1_23_a0 <= STD_LOGIC_VECTOR(u0_m0_wo0_cm7_q);
    u0_m0_wo0_mtree_mult1_23_b0 <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_delayr7_q);
    u0_m0_wo0_mtree_mult1_23_reset <= areset;
    u0_m0_wo0_mtree_mult1_23_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 14,
        lpm_widthb => 14,
        lpm_widthp => 28,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "SIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => u0_m0_wo0_mtree_mult1_23_a0,
        datab => u0_m0_wo0_mtree_mult1_23_b0,
        clken => VCC_q(0),
        aclr => u0_m0_wo0_mtree_mult1_23_reset,
        clock => clk,
        result => u0_m0_wo0_mtree_mult1_23_s1
    );
    u0_m0_wo0_mtree_mult1_23_q <= u0_m0_wo0_mtree_mult1_23_s1;

    -- u0_m0_wo0_wi0_delayr8(DELAY,18)@10
    u0_m0_wo0_wi0_delayr8 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr7_q, xout => u0_m0_wo0_wi0_delayr8_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_cm8(CONSTANT,49)@0
    u0_m0_wo0_cm8_q <= "01110100111000";

    -- u0_m0_wo0_mtree_mult1_22(MULT,80)@10
    u0_m0_wo0_mtree_mult1_22_a0 <= STD_LOGIC_VECTOR(u0_m0_wo0_cm8_q);
    u0_m0_wo0_mtree_mult1_22_b0 <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_delayr8_q);
    u0_m0_wo0_mtree_mult1_22_reset <= areset;
    u0_m0_wo0_mtree_mult1_22_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 14,
        lpm_widthb => 14,
        lpm_widthp => 28,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "SIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => u0_m0_wo0_mtree_mult1_22_a0,
        datab => u0_m0_wo0_mtree_mult1_22_b0,
        clken => VCC_q(0),
        aclr => u0_m0_wo0_mtree_mult1_22_reset,
        clock => clk,
        result => u0_m0_wo0_mtree_mult1_22_s1
    );
    u0_m0_wo0_mtree_mult1_22_q <= u0_m0_wo0_mtree_mult1_22_s1;

    -- u0_m0_wo0_mtree_add0_11(ADD,114)@12
    u0_m0_wo0_mtree_add0_11_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_mult1_22_q(27)) & u0_m0_wo0_mtree_mult1_22_q));
    u0_m0_wo0_mtree_add0_11_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_mult1_23_q(27)) & u0_m0_wo0_mtree_mult1_23_q));
    u0_m0_wo0_mtree_add0_11: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add0_11_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add0_11_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add0_11_a) + SIGNED(u0_m0_wo0_mtree_add0_11_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add0_11_q <= u0_m0_wo0_mtree_add0_11_o(28 downto 0);

    -- u0_m0_wo0_wi0_delayr9(DELAY,19)@10
    u0_m0_wo0_wi0_delayr9 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr8_q, xout => u0_m0_wo0_wi0_delayr9_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_mtree_mult1_21_shift2(BITSHIFT,222)@10
    u0_m0_wo0_mtree_mult1_21_shift2_q_int <= u0_m0_wo0_wi0_delayr9_q & "0000";
    u0_m0_wo0_mtree_mult1_21_shift2_q <= u0_m0_wo0_mtree_mult1_21_shift2_q_int(17 downto 0);

    -- u0_m0_wo0_mtree_mult1_21_sub_3(SUB,223)@10
    u0_m0_wo0_mtree_mult1_21_sub_3_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 18 => u0_m0_wo0_mtree_mult1_21_shift2_q(17)) & u0_m0_wo0_mtree_mult1_21_shift2_q));
    u0_m0_wo0_mtree_mult1_21_sub_3_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 14 => u0_m0_wo0_wi0_delayr9_q(13)) & u0_m0_wo0_wi0_delayr9_q));
    u0_m0_wo0_mtree_mult1_21_sub_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_21_sub_3_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_21_sub_3_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_21_sub_3_a) - SIGNED(u0_m0_wo0_mtree_mult1_21_sub_3_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_21_sub_3_q <= u0_m0_wo0_mtree_mult1_21_sub_3_o(18 downto 0);

    -- u0_m0_wo0_mtree_mult1_21_shift4(BITSHIFT,224)@11
    u0_m0_wo0_mtree_mult1_21_shift4_q_int <= u0_m0_wo0_mtree_mult1_21_sub_3_q & "000000000";
    u0_m0_wo0_mtree_mult1_21_shift4_q <= u0_m0_wo0_mtree_mult1_21_shift4_q_int(27 downto 0);

    -- u0_m0_wo0_mtree_mult1_21_shift0(BITSHIFT,220)@10
    u0_m0_wo0_mtree_mult1_21_shift0_q_int <= u0_m0_wo0_wi0_delayr9_q & "0000";
    u0_m0_wo0_mtree_mult1_21_shift0_q <= u0_m0_wo0_mtree_mult1_21_shift0_q_int(17 downto 0);

    -- u0_m0_wo0_mtree_mult1_21_sub_1(SUB,221)@10
    u0_m0_wo0_mtree_mult1_21_sub_1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 14 => u0_m0_wo0_wi0_delayr9_q(13)) & u0_m0_wo0_wi0_delayr9_q));
    u0_m0_wo0_mtree_mult1_21_sub_1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 18 => u0_m0_wo0_mtree_mult1_21_shift0_q(17)) & u0_m0_wo0_mtree_mult1_21_shift0_q));
    u0_m0_wo0_mtree_mult1_21_sub_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_21_sub_1_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_21_sub_1_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_21_sub_1_a) - SIGNED(u0_m0_wo0_mtree_mult1_21_sub_1_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_21_sub_1_q <= u0_m0_wo0_mtree_mult1_21_sub_1_o(18 downto 0);

    -- u0_m0_wo0_mtree_mult1_21_add_5(ADD,225)@11
    u0_m0_wo0_mtree_mult1_21_add_5_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 19 => u0_m0_wo0_mtree_mult1_21_sub_1_q(18)) & u0_m0_wo0_mtree_mult1_21_sub_1_q));
    u0_m0_wo0_mtree_mult1_21_add_5_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_mult1_21_shift4_q(27)) & u0_m0_wo0_mtree_mult1_21_shift4_q));
    u0_m0_wo0_mtree_mult1_21_add_5: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_21_add_5_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_21_add_5_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_21_add_5_a) + SIGNED(u0_m0_wo0_mtree_mult1_21_add_5_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_21_add_5_q <= u0_m0_wo0_mtree_mult1_21_add_5_o(28 downto 0);

    -- u0_m0_wo0_wi0_delayr10(DELAY,20)@10
    u0_m0_wo0_wi0_delayr10 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr9_q, xout => u0_m0_wo0_wi0_delayr10_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_cm10(CONSTANT,51)@0
    u0_m0_wo0_cm10_q <= "01111010001111";

    -- u0_m0_wo0_mtree_mult1_20(MULT,82)@10
    u0_m0_wo0_mtree_mult1_20_a0 <= STD_LOGIC_VECTOR(u0_m0_wo0_cm10_q);
    u0_m0_wo0_mtree_mult1_20_b0 <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_delayr10_q);
    u0_m0_wo0_mtree_mult1_20_reset <= areset;
    u0_m0_wo0_mtree_mult1_20_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 14,
        lpm_widthb => 14,
        lpm_widthp => 28,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "SIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => u0_m0_wo0_mtree_mult1_20_a0,
        datab => u0_m0_wo0_mtree_mult1_20_b0,
        clken => VCC_q(0),
        aclr => u0_m0_wo0_mtree_mult1_20_reset,
        clock => clk,
        result => u0_m0_wo0_mtree_mult1_20_s1
    );
    u0_m0_wo0_mtree_mult1_20_q <= u0_m0_wo0_mtree_mult1_20_s1;

    -- u0_m0_wo0_mtree_add0_10(ADD,113)@12
    u0_m0_wo0_mtree_add0_10_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_mult1_20_q(27)) & u0_m0_wo0_mtree_mult1_20_q));
    u0_m0_wo0_mtree_add0_10_b <= STD_LOGIC_VECTOR(u0_m0_wo0_mtree_mult1_21_add_5_q);
    u0_m0_wo0_mtree_add0_10: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add0_10_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add0_10_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add0_10_a) + SIGNED(u0_m0_wo0_mtree_add0_10_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add0_10_q <= u0_m0_wo0_mtree_add0_10_o(28 downto 0);

    -- u0_m0_wo0_mtree_add1_5(ADD,123)@13
    u0_m0_wo0_mtree_add1_5_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 29 => u0_m0_wo0_mtree_add0_10_q(28)) & u0_m0_wo0_mtree_add0_10_q));
    u0_m0_wo0_mtree_add1_5_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 29 => u0_m0_wo0_mtree_add0_11_q(28)) & u0_m0_wo0_mtree_add0_11_q));
    u0_m0_wo0_mtree_add1_5: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add1_5_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add1_5_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add1_5_a) + SIGNED(u0_m0_wo0_mtree_add1_5_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add1_5_q <= u0_m0_wo0_mtree_add1_5_o(29 downto 0);

    -- u0_m0_wo0_wi0_delayr11(DELAY,21)@10
    u0_m0_wo0_wi0_delayr11 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr10_q, xout => u0_m0_wo0_wi0_delayr11_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_mtree_mult1_19_shift2(BITSHIFT,236)@10
    u0_m0_wo0_mtree_mult1_19_shift2_q_int <= u0_m0_wo0_wi0_delayr11_q & "00000";
    u0_m0_wo0_mtree_mult1_19_shift2_q <= u0_m0_wo0_mtree_mult1_19_shift2_q_int(18 downto 0);

    -- u0_m0_wo0_mtree_mult1_19_sub_3(SUB,237)@10
    u0_m0_wo0_mtree_mult1_19_sub_3_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((19 downto 19 => u0_m0_wo0_mtree_mult1_19_shift2_q(18)) & u0_m0_wo0_mtree_mult1_19_shift2_q));
    u0_m0_wo0_mtree_mult1_19_sub_3_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((19 downto 14 => u0_m0_wo0_wi0_delayr11_q(13)) & u0_m0_wo0_wi0_delayr11_q));
    u0_m0_wo0_mtree_mult1_19_sub_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_19_sub_3_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_19_sub_3_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_19_sub_3_a) - SIGNED(u0_m0_wo0_mtree_mult1_19_sub_3_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_19_sub_3_q <= u0_m0_wo0_mtree_mult1_19_sub_3_o(19 downto 0);

    -- u0_m0_wo0_mtree_mult1_19_shift4(BITSHIFT,238)@11
    u0_m0_wo0_mtree_mult1_19_shift4_q_int <= u0_m0_wo0_mtree_mult1_19_sub_3_q & "0000000";
    u0_m0_wo0_mtree_mult1_19_shift4_q <= u0_m0_wo0_mtree_mult1_19_shift4_q_int(26 downto 0);

    -- u0_m0_wo0_mtree_mult1_19_shift0(BITSHIFT,234)@10
    u0_m0_wo0_mtree_mult1_19_shift0_q_int <= u0_m0_wo0_wi0_delayr11_q & "000";
    u0_m0_wo0_mtree_mult1_19_shift0_q <= u0_m0_wo0_mtree_mult1_19_shift0_q_int(16 downto 0);

    -- u0_m0_wo0_mtree_mult1_19_add_1(ADD,235)@10
    u0_m0_wo0_mtree_mult1_19_add_1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 14 => u0_m0_wo0_wi0_delayr11_q(13)) & u0_m0_wo0_wi0_delayr11_q));
    u0_m0_wo0_mtree_mult1_19_add_1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 17 => u0_m0_wo0_mtree_mult1_19_shift0_q(16)) & u0_m0_wo0_mtree_mult1_19_shift0_q));
    u0_m0_wo0_mtree_mult1_19_add_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_19_add_1_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_19_add_1_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_19_add_1_a) + SIGNED(u0_m0_wo0_mtree_mult1_19_add_1_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_19_add_1_q <= u0_m0_wo0_mtree_mult1_19_add_1_o(17 downto 0);

    -- u0_m0_wo0_mtree_mult1_19_add_5(ADD,239)@11
    u0_m0_wo0_mtree_mult1_19_add_5_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 18 => u0_m0_wo0_mtree_mult1_19_add_1_q(17)) & u0_m0_wo0_mtree_mult1_19_add_1_q));
    u0_m0_wo0_mtree_mult1_19_add_5_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 27 => u0_m0_wo0_mtree_mult1_19_shift4_q(26)) & u0_m0_wo0_mtree_mult1_19_shift4_q));
    u0_m0_wo0_mtree_mult1_19_add_5: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_19_add_5_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_19_add_5_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_19_add_5_a) + SIGNED(u0_m0_wo0_mtree_mult1_19_add_5_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_19_add_5_q <= u0_m0_wo0_mtree_mult1_19_add_5_o(27 downto 0);

    -- u0_m0_wo0_mtree_mult1_19_shift6(BITSHIFT,240)@12
    u0_m0_wo0_mtree_mult1_19_shift6_q_int <= u0_m0_wo0_mtree_mult1_19_add_5_q & "0";
    u0_m0_wo0_mtree_mult1_19_shift6_q <= u0_m0_wo0_mtree_mult1_19_shift6_q_int(28 downto 0);

    -- u0_m0_wo0_wi0_delayr12(DELAY,22)@10
    u0_m0_wo0_wi0_delayr12 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr11_q, xout => u0_m0_wo0_wi0_delayr12_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_mtree_mult1_18_shift2(BITSHIFT,243)@10
    u0_m0_wo0_mtree_mult1_18_shift2_q_int <= u0_m0_wo0_wi0_delayr12_q & "000000";
    u0_m0_wo0_mtree_mult1_18_shift2_q <= u0_m0_wo0_mtree_mult1_18_shift2_q_int(19 downto 0);

    -- u0_m0_wo0_mtree_mult1_18_sub_3(SUB,244)@10
    u0_m0_wo0_mtree_mult1_18_sub_3_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((20 downto 20 => u0_m0_wo0_mtree_mult1_18_shift2_q(19)) & u0_m0_wo0_mtree_mult1_18_shift2_q));
    u0_m0_wo0_mtree_mult1_18_sub_3_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((20 downto 14 => u0_m0_wo0_wi0_delayr12_q(13)) & u0_m0_wo0_wi0_delayr12_q));
    u0_m0_wo0_mtree_mult1_18_sub_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_18_sub_3_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_18_sub_3_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_18_sub_3_a) - SIGNED(u0_m0_wo0_mtree_mult1_18_sub_3_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_18_sub_3_q <= u0_m0_wo0_mtree_mult1_18_sub_3_o(20 downto 0);

    -- u0_m0_wo0_mtree_mult1_18_shift4(BITSHIFT,245)@11
    u0_m0_wo0_mtree_mult1_18_shift4_q_int <= u0_m0_wo0_mtree_mult1_18_sub_3_q & "000000";
    u0_m0_wo0_mtree_mult1_18_shift4_q <= u0_m0_wo0_mtree_mult1_18_shift4_q_int(26 downto 0);

    -- u0_m0_wo0_mtree_mult1_18_shift0(BITSHIFT,241)@10
    u0_m0_wo0_mtree_mult1_18_shift0_q_int <= u0_m0_wo0_wi0_delayr12_q & "00";
    u0_m0_wo0_mtree_mult1_18_shift0_q <= u0_m0_wo0_mtree_mult1_18_shift0_q_int(15 downto 0);

    -- u0_m0_wo0_mtree_mult1_18_sub_1(SUB,242)@10
    u0_m0_wo0_mtree_mult1_18_sub_1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 14 => u0_m0_wo0_wi0_delayr12_q(13)) & u0_m0_wo0_wi0_delayr12_q));
    u0_m0_wo0_mtree_mult1_18_sub_1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 16 => u0_m0_wo0_mtree_mult1_18_shift0_q(15)) & u0_m0_wo0_mtree_mult1_18_shift0_q));
    u0_m0_wo0_mtree_mult1_18_sub_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_18_sub_1_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_18_sub_1_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_18_sub_1_a) - SIGNED(u0_m0_wo0_mtree_mult1_18_sub_1_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_18_sub_1_q <= u0_m0_wo0_mtree_mult1_18_sub_1_o(16 downto 0);

    -- u0_m0_wo0_mtree_mult1_18_add_5(ADD,246)@11
    u0_m0_wo0_mtree_mult1_18_add_5_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 17 => u0_m0_wo0_mtree_mult1_18_sub_1_q(16)) & u0_m0_wo0_mtree_mult1_18_sub_1_q));
    u0_m0_wo0_mtree_mult1_18_add_5_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 27 => u0_m0_wo0_mtree_mult1_18_shift4_q(26)) & u0_m0_wo0_mtree_mult1_18_shift4_q));
    u0_m0_wo0_mtree_mult1_18_add_5: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_18_add_5_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_18_add_5_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_18_add_5_a) + SIGNED(u0_m0_wo0_mtree_mult1_18_add_5_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_18_add_5_q <= u0_m0_wo0_mtree_mult1_18_add_5_o(27 downto 0);

    -- u0_m0_wo0_mtree_mult1_18_shift6(BITSHIFT,247)@12
    u0_m0_wo0_mtree_mult1_18_shift6_q_int <= u0_m0_wo0_mtree_mult1_18_add_5_q & "0";
    u0_m0_wo0_mtree_mult1_18_shift6_q <= u0_m0_wo0_mtree_mult1_18_shift6_q_int(28 downto 0);

    -- u0_m0_wo0_mtree_add0_9(ADD,112)@12
    u0_m0_wo0_mtree_add0_9_a <= STD_LOGIC_VECTOR(u0_m0_wo0_mtree_mult1_18_shift6_q);
    u0_m0_wo0_mtree_add0_9_b <= STD_LOGIC_VECTOR(u0_m0_wo0_mtree_mult1_19_shift6_q);
    u0_m0_wo0_mtree_add0_9: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add0_9_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add0_9_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add0_9_a) + SIGNED(u0_m0_wo0_mtree_add0_9_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add0_9_q <= u0_m0_wo0_mtree_add0_9_o(28 downto 0);

    -- u0_m0_wo0_wi0_delayr13(DELAY,23)@10
    u0_m0_wo0_wi0_delayr13 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr12_q, xout => u0_m0_wo0_wi0_delayr13_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- d_u0_m0_wo0_wi0_delayr13_q_11(DELAY,711)@10
    d_u0_m0_wo0_wi0_delayr13_q_11 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr13_q, xout => d_u0_m0_wo0_wi0_delayr13_q_11_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_mtree_mult1_17_shift2(BITSHIFT,250)@11
    u0_m0_wo0_mtree_mult1_17_shift2_q_int <= d_u0_m0_wo0_wi0_delayr13_q_11_q & "00000000000";
    u0_m0_wo0_mtree_mult1_17_shift2_q <= u0_m0_wo0_mtree_mult1_17_shift2_q_int(24 downto 0);

    -- u0_m0_wo0_mtree_mult1_17_shift0(BITSHIFT,248)@10
    u0_m0_wo0_mtree_mult1_17_shift0_q_int <= u0_m0_wo0_wi0_delayr13_q & "0000";
    u0_m0_wo0_mtree_mult1_17_shift0_q <= u0_m0_wo0_mtree_mult1_17_shift0_q_int(17 downto 0);

    -- u0_m0_wo0_mtree_mult1_17_sub_1(SUB,249)@10
    u0_m0_wo0_mtree_mult1_17_sub_1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 14 => u0_m0_wo0_wi0_delayr13_q(13)) & u0_m0_wo0_wi0_delayr13_q));
    u0_m0_wo0_mtree_mult1_17_sub_1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 18 => u0_m0_wo0_mtree_mult1_17_shift0_q(17)) & u0_m0_wo0_mtree_mult1_17_shift0_q));
    u0_m0_wo0_mtree_mult1_17_sub_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_17_sub_1_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_17_sub_1_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_17_sub_1_a) - SIGNED(u0_m0_wo0_mtree_mult1_17_sub_1_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_17_sub_1_q <= u0_m0_wo0_mtree_mult1_17_sub_1_o(18 downto 0);

    -- u0_m0_wo0_mtree_mult1_17_add_3(ADD,251)@11
    u0_m0_wo0_mtree_mult1_17_add_3_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((25 downto 19 => u0_m0_wo0_mtree_mult1_17_sub_1_q(18)) & u0_m0_wo0_mtree_mult1_17_sub_1_q));
    u0_m0_wo0_mtree_mult1_17_add_3_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((25 downto 25 => u0_m0_wo0_mtree_mult1_17_shift2_q(24)) & u0_m0_wo0_mtree_mult1_17_shift2_q));
    u0_m0_wo0_mtree_mult1_17_add_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_17_add_3_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_17_add_3_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_17_add_3_a) + SIGNED(u0_m0_wo0_mtree_mult1_17_add_3_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_17_add_3_q <= u0_m0_wo0_mtree_mult1_17_add_3_o(25 downto 0);

    -- u0_m0_wo0_mtree_mult1_17_shift4(BITSHIFT,252)@12
    u0_m0_wo0_mtree_mult1_17_shift4_q_int <= u0_m0_wo0_mtree_mult1_17_add_3_q & "00";
    u0_m0_wo0_mtree_mult1_17_shift4_q <= u0_m0_wo0_mtree_mult1_17_shift4_q_int(27 downto 0);

    -- u0_m0_wo0_mtree_mult1_16_shift0(BITSHIFT,253)@10
    u0_m0_wo0_mtree_mult1_16_shift0_q_int <= u0_m0_wo0_wi0_delayr14_q & "0000";
    u0_m0_wo0_mtree_mult1_16_shift0_q <= u0_m0_wo0_mtree_mult1_16_shift0_q_int(17 downto 0);

    -- u0_m0_wo0_wi0_delayr14(DELAY,24)@10
    u0_m0_wo0_wi0_delayr14 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr13_q, xout => u0_m0_wo0_wi0_delayr14_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_mtree_mult1_16_add_1(ADD,254)@10
    u0_m0_wo0_mtree_mult1_16_add_1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 14 => u0_m0_wo0_wi0_delayr14_q(13)) & u0_m0_wo0_wi0_delayr14_q));
    u0_m0_wo0_mtree_mult1_16_add_1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 18 => u0_m0_wo0_mtree_mult1_16_shift0_q(17)) & u0_m0_wo0_mtree_mult1_16_shift0_q));
    u0_m0_wo0_mtree_mult1_16_add_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_16_add_1_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_16_add_1_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_16_add_1_a) + SIGNED(u0_m0_wo0_mtree_mult1_16_add_1_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_16_add_1_q <= u0_m0_wo0_mtree_mult1_16_add_1_o(18 downto 0);

    -- d_u0_m0_wo0_wi0_delayr14_q_11(DELAY,712)@10
    d_u0_m0_wo0_wi0_delayr14_q_11 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr14_q, xout => d_u0_m0_wo0_wi0_delayr14_q_11_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_mtree_mult1_16_shift2(BITSHIFT,255)@11
    u0_m0_wo0_mtree_mult1_16_shift2_q_int <= d_u0_m0_wo0_wi0_delayr14_q_11_q & "0000000000000";
    u0_m0_wo0_mtree_mult1_16_shift2_q <= u0_m0_wo0_mtree_mult1_16_shift2_q_int(26 downto 0);

    -- u0_m0_wo0_mtree_mult1_16_sub_3(SUB,256)@11
    u0_m0_wo0_mtree_mult1_16_sub_3_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 27 => u0_m0_wo0_mtree_mult1_16_shift2_q(26)) & u0_m0_wo0_mtree_mult1_16_shift2_q));
    u0_m0_wo0_mtree_mult1_16_sub_3_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 19 => u0_m0_wo0_mtree_mult1_16_add_1_q(18)) & u0_m0_wo0_mtree_mult1_16_add_1_q));
    u0_m0_wo0_mtree_mult1_16_sub_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_16_sub_3_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_16_sub_3_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_16_sub_3_a) - SIGNED(u0_m0_wo0_mtree_mult1_16_sub_3_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_16_sub_3_q <= u0_m0_wo0_mtree_mult1_16_sub_3_o(27 downto 0);

    -- u0_m0_wo0_mtree_add0_8(ADD,111)@12
    u0_m0_wo0_mtree_add0_8_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_mult1_16_sub_3_q(27)) & u0_m0_wo0_mtree_mult1_16_sub_3_q));
    u0_m0_wo0_mtree_add0_8_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_mult1_17_shift4_q(27)) & u0_m0_wo0_mtree_mult1_17_shift4_q));
    u0_m0_wo0_mtree_add0_8: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add0_8_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add0_8_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add0_8_a) + SIGNED(u0_m0_wo0_mtree_add0_8_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add0_8_q <= u0_m0_wo0_mtree_add0_8_o(28 downto 0);

    -- u0_m0_wo0_mtree_add1_4(ADD,122)@13
    u0_m0_wo0_mtree_add1_4_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 29 => u0_m0_wo0_mtree_add0_8_q(28)) & u0_m0_wo0_mtree_add0_8_q));
    u0_m0_wo0_mtree_add1_4_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 29 => u0_m0_wo0_mtree_add0_9_q(28)) & u0_m0_wo0_mtree_add0_9_q));
    u0_m0_wo0_mtree_add1_4: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add1_4_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add1_4_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add1_4_a) + SIGNED(u0_m0_wo0_mtree_add1_4_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add1_4_q <= u0_m0_wo0_mtree_add1_4_o(29 downto 0);

    -- u0_m0_wo0_mtree_add2_2(ADD,128)@14
    u0_m0_wo0_mtree_add2_2_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 30 => u0_m0_wo0_mtree_add1_4_q(29)) & u0_m0_wo0_mtree_add1_4_q));
    u0_m0_wo0_mtree_add2_2_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 30 => u0_m0_wo0_mtree_add1_5_q(29)) & u0_m0_wo0_mtree_add1_5_q));
    u0_m0_wo0_mtree_add2_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add2_2_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add2_2_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add2_2_a) + SIGNED(u0_m0_wo0_mtree_add2_2_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add2_2_q <= u0_m0_wo0_mtree_add2_2_o(30 downto 0);

    -- u0_m0_wo0_mtree_add3_1(ADD,131)@15
    u0_m0_wo0_mtree_add3_1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((31 downto 31 => u0_m0_wo0_mtree_add2_2_q(30)) & u0_m0_wo0_mtree_add2_2_q));
    u0_m0_wo0_mtree_add3_1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((31 downto 31 => u0_m0_wo0_mtree_add2_3_q(30)) & u0_m0_wo0_mtree_add2_3_q));
    u0_m0_wo0_mtree_add3_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add3_1_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add3_1_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add3_1_a) + SIGNED(u0_m0_wo0_mtree_add3_1_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add3_1_q <= u0_m0_wo0_mtree_add3_1_o(31 downto 0);

    -- u0_m0_wo0_wi0_delayr15(DELAY,25)@10
    u0_m0_wo0_wi0_delayr15 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr14_q, xout => u0_m0_wo0_wi0_delayr15_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- d_u0_m0_wo0_wi0_delayr15_q_11(DELAY,713)@10
    d_u0_m0_wo0_wi0_delayr15_q_11 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr15_q, xout => d_u0_m0_wo0_wi0_delayr15_q_11_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_mtree_mult1_15_shift0(BITSHIFT,257)@11
    u0_m0_wo0_mtree_mult1_15_shift0_q_int <= d_u0_m0_wo0_wi0_delayr15_q_11_q & "0000000000000";
    u0_m0_wo0_mtree_mult1_15_shift0_q <= u0_m0_wo0_mtree_mult1_15_shift0_q_int(26 downto 0);

    -- u0_m0_wo0_mtree_mult1_15_sub_1(SUB,258)@11
    u0_m0_wo0_mtree_mult1_15_sub_1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 27 => u0_m0_wo0_mtree_mult1_15_shift0_q(26)) & u0_m0_wo0_mtree_mult1_15_shift0_q));
    u0_m0_wo0_mtree_mult1_15_sub_1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 14 => d_u0_m0_wo0_wi0_delayr15_q_11_q(13)) & d_u0_m0_wo0_wi0_delayr15_q_11_q));
    u0_m0_wo0_mtree_mult1_15_sub_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_15_sub_1_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_15_sub_1_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_15_sub_1_a) - SIGNED(u0_m0_wo0_mtree_mult1_15_sub_1_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_15_sub_1_q <= u0_m0_wo0_mtree_mult1_15_sub_1_o(27 downto 0);

    -- u0_m0_wo0_mtree_mult1_14_shift0(BITSHIFT,259)@10
    u0_m0_wo0_mtree_mult1_14_shift0_q_int <= u0_m0_wo0_wi0_delayr16_q & "0000";
    u0_m0_wo0_mtree_mult1_14_shift0_q <= u0_m0_wo0_mtree_mult1_14_shift0_q_int(17 downto 0);

    -- u0_m0_wo0_wi0_delayr16(DELAY,26)@10
    u0_m0_wo0_wi0_delayr16 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr15_q, xout => u0_m0_wo0_wi0_delayr16_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_mtree_mult1_14_add_1(ADD,260)@10
    u0_m0_wo0_mtree_mult1_14_add_1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 14 => u0_m0_wo0_wi0_delayr16_q(13)) & u0_m0_wo0_wi0_delayr16_q));
    u0_m0_wo0_mtree_mult1_14_add_1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 18 => u0_m0_wo0_mtree_mult1_14_shift0_q(17)) & u0_m0_wo0_mtree_mult1_14_shift0_q));
    u0_m0_wo0_mtree_mult1_14_add_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_14_add_1_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_14_add_1_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_14_add_1_a) + SIGNED(u0_m0_wo0_mtree_mult1_14_add_1_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_14_add_1_q <= u0_m0_wo0_mtree_mult1_14_add_1_o(18 downto 0);

    -- d_u0_m0_wo0_wi0_delayr16_q_11(DELAY,714)@10
    d_u0_m0_wo0_wi0_delayr16_q_11 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr16_q, xout => d_u0_m0_wo0_wi0_delayr16_q_11_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_mtree_mult1_14_shift2(BITSHIFT,261)@11
    u0_m0_wo0_mtree_mult1_14_shift2_q_int <= d_u0_m0_wo0_wi0_delayr16_q_11_q & "0000000000000";
    u0_m0_wo0_mtree_mult1_14_shift2_q <= u0_m0_wo0_mtree_mult1_14_shift2_q_int(26 downto 0);

    -- u0_m0_wo0_mtree_mult1_14_sub_3(SUB,262)@11
    u0_m0_wo0_mtree_mult1_14_sub_3_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 27 => u0_m0_wo0_mtree_mult1_14_shift2_q(26)) & u0_m0_wo0_mtree_mult1_14_shift2_q));
    u0_m0_wo0_mtree_mult1_14_sub_3_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 19 => u0_m0_wo0_mtree_mult1_14_add_1_q(18)) & u0_m0_wo0_mtree_mult1_14_add_1_q));
    u0_m0_wo0_mtree_mult1_14_sub_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_14_sub_3_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_14_sub_3_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_14_sub_3_a) - SIGNED(u0_m0_wo0_mtree_mult1_14_sub_3_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_14_sub_3_q <= u0_m0_wo0_mtree_mult1_14_sub_3_o(27 downto 0);

    -- u0_m0_wo0_mtree_add0_7(ADD,110)@12
    u0_m0_wo0_mtree_add0_7_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_mult1_14_sub_3_q(27)) & u0_m0_wo0_mtree_mult1_14_sub_3_q));
    u0_m0_wo0_mtree_add0_7_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_mult1_15_sub_1_q(27)) & u0_m0_wo0_mtree_mult1_15_sub_1_q));
    u0_m0_wo0_mtree_add0_7: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add0_7_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add0_7_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add0_7_a) + SIGNED(u0_m0_wo0_mtree_add0_7_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add0_7_q <= u0_m0_wo0_mtree_add0_7_o(28 downto 0);

    -- u0_m0_wo0_wi0_delayr17(DELAY,27)@10
    u0_m0_wo0_wi0_delayr17 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr16_q, xout => u0_m0_wo0_wi0_delayr17_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- d_u0_m0_wo0_wi0_delayr17_q_11(DELAY,715)@10
    d_u0_m0_wo0_wi0_delayr17_q_11 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr17_q, xout => d_u0_m0_wo0_wi0_delayr17_q_11_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_mtree_mult1_13_shift2(BITSHIFT,265)@11
    u0_m0_wo0_mtree_mult1_13_shift2_q_int <= d_u0_m0_wo0_wi0_delayr17_q_11_q & "00000000000";
    u0_m0_wo0_mtree_mult1_13_shift2_q <= u0_m0_wo0_mtree_mult1_13_shift2_q_int(24 downto 0);

    -- u0_m0_wo0_mtree_mult1_13_shift0(BITSHIFT,263)@10
    u0_m0_wo0_mtree_mult1_13_shift0_q_int <= u0_m0_wo0_wi0_delayr17_q & "0000";
    u0_m0_wo0_mtree_mult1_13_shift0_q <= u0_m0_wo0_mtree_mult1_13_shift0_q_int(17 downto 0);

    -- u0_m0_wo0_mtree_mult1_13_sub_1(SUB,264)@10
    u0_m0_wo0_mtree_mult1_13_sub_1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 14 => u0_m0_wo0_wi0_delayr17_q(13)) & u0_m0_wo0_wi0_delayr17_q));
    u0_m0_wo0_mtree_mult1_13_sub_1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 18 => u0_m0_wo0_mtree_mult1_13_shift0_q(17)) & u0_m0_wo0_mtree_mult1_13_shift0_q));
    u0_m0_wo0_mtree_mult1_13_sub_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_13_sub_1_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_13_sub_1_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_13_sub_1_a) - SIGNED(u0_m0_wo0_mtree_mult1_13_sub_1_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_13_sub_1_q <= u0_m0_wo0_mtree_mult1_13_sub_1_o(18 downto 0);

    -- u0_m0_wo0_mtree_mult1_13_add_3(ADD,266)@11
    u0_m0_wo0_mtree_mult1_13_add_3_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((25 downto 19 => u0_m0_wo0_mtree_mult1_13_sub_1_q(18)) & u0_m0_wo0_mtree_mult1_13_sub_1_q));
    u0_m0_wo0_mtree_mult1_13_add_3_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((25 downto 25 => u0_m0_wo0_mtree_mult1_13_shift2_q(24)) & u0_m0_wo0_mtree_mult1_13_shift2_q));
    u0_m0_wo0_mtree_mult1_13_add_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_13_add_3_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_13_add_3_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_13_add_3_a) + SIGNED(u0_m0_wo0_mtree_mult1_13_add_3_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_13_add_3_q <= u0_m0_wo0_mtree_mult1_13_add_3_o(25 downto 0);

    -- u0_m0_wo0_mtree_mult1_13_shift4(BITSHIFT,267)@12
    u0_m0_wo0_mtree_mult1_13_shift4_q_int <= u0_m0_wo0_mtree_mult1_13_add_3_q & "00";
    u0_m0_wo0_mtree_mult1_13_shift4_q <= u0_m0_wo0_mtree_mult1_13_shift4_q_int(27 downto 0);

    -- u0_m0_wo0_wi0_delayr18(DELAY,28)@10
    u0_m0_wo0_wi0_delayr18 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr17_q, xout => u0_m0_wo0_wi0_delayr18_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_mtree_mult1_12_shift2(BITSHIFT,270)@10
    u0_m0_wo0_mtree_mult1_12_shift2_q_int <= u0_m0_wo0_wi0_delayr18_q & "000000";
    u0_m0_wo0_mtree_mult1_12_shift2_q <= u0_m0_wo0_mtree_mult1_12_shift2_q_int(19 downto 0);

    -- u0_m0_wo0_mtree_mult1_12_sub_3(SUB,271)@10
    u0_m0_wo0_mtree_mult1_12_sub_3_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((20 downto 20 => u0_m0_wo0_mtree_mult1_12_shift2_q(19)) & u0_m0_wo0_mtree_mult1_12_shift2_q));
    u0_m0_wo0_mtree_mult1_12_sub_3_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((20 downto 14 => u0_m0_wo0_wi0_delayr18_q(13)) & u0_m0_wo0_wi0_delayr18_q));
    u0_m0_wo0_mtree_mult1_12_sub_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_12_sub_3_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_12_sub_3_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_12_sub_3_a) - SIGNED(u0_m0_wo0_mtree_mult1_12_sub_3_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_12_sub_3_q <= u0_m0_wo0_mtree_mult1_12_sub_3_o(20 downto 0);

    -- u0_m0_wo0_mtree_mult1_12_shift4(BITSHIFT,272)@11
    u0_m0_wo0_mtree_mult1_12_shift4_q_int <= u0_m0_wo0_mtree_mult1_12_sub_3_q & "000000";
    u0_m0_wo0_mtree_mult1_12_shift4_q <= u0_m0_wo0_mtree_mult1_12_shift4_q_int(26 downto 0);

    -- u0_m0_wo0_mtree_mult1_12_shift0(BITSHIFT,268)@10
    u0_m0_wo0_mtree_mult1_12_shift0_q_int <= u0_m0_wo0_wi0_delayr18_q & "00";
    u0_m0_wo0_mtree_mult1_12_shift0_q <= u0_m0_wo0_mtree_mult1_12_shift0_q_int(15 downto 0);

    -- u0_m0_wo0_mtree_mult1_12_sub_1(SUB,269)@10
    u0_m0_wo0_mtree_mult1_12_sub_1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 14 => u0_m0_wo0_wi0_delayr18_q(13)) & u0_m0_wo0_wi0_delayr18_q));
    u0_m0_wo0_mtree_mult1_12_sub_1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 16 => u0_m0_wo0_mtree_mult1_12_shift0_q(15)) & u0_m0_wo0_mtree_mult1_12_shift0_q));
    u0_m0_wo0_mtree_mult1_12_sub_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_12_sub_1_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_12_sub_1_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_12_sub_1_a) - SIGNED(u0_m0_wo0_mtree_mult1_12_sub_1_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_12_sub_1_q <= u0_m0_wo0_mtree_mult1_12_sub_1_o(16 downto 0);

    -- u0_m0_wo0_mtree_mult1_12_add_5(ADD,273)@11
    u0_m0_wo0_mtree_mult1_12_add_5_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 17 => u0_m0_wo0_mtree_mult1_12_sub_1_q(16)) & u0_m0_wo0_mtree_mult1_12_sub_1_q));
    u0_m0_wo0_mtree_mult1_12_add_5_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 27 => u0_m0_wo0_mtree_mult1_12_shift4_q(26)) & u0_m0_wo0_mtree_mult1_12_shift4_q));
    u0_m0_wo0_mtree_mult1_12_add_5: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_12_add_5_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_12_add_5_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_12_add_5_a) + SIGNED(u0_m0_wo0_mtree_mult1_12_add_5_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_12_add_5_q <= u0_m0_wo0_mtree_mult1_12_add_5_o(27 downto 0);

    -- u0_m0_wo0_mtree_mult1_12_shift6(BITSHIFT,274)@12
    u0_m0_wo0_mtree_mult1_12_shift6_q_int <= u0_m0_wo0_mtree_mult1_12_add_5_q & "0";
    u0_m0_wo0_mtree_mult1_12_shift6_q <= u0_m0_wo0_mtree_mult1_12_shift6_q_int(28 downto 0);

    -- u0_m0_wo0_mtree_add0_6(ADD,109)@12
    u0_m0_wo0_mtree_add0_6_a <= STD_LOGIC_VECTOR(u0_m0_wo0_mtree_mult1_12_shift6_q);
    u0_m0_wo0_mtree_add0_6_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_mult1_13_shift4_q(27)) & u0_m0_wo0_mtree_mult1_13_shift4_q));
    u0_m0_wo0_mtree_add0_6: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add0_6_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add0_6_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add0_6_a) + SIGNED(u0_m0_wo0_mtree_add0_6_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add0_6_q <= u0_m0_wo0_mtree_add0_6_o(28 downto 0);

    -- u0_m0_wo0_mtree_add1_3(ADD,121)@13
    u0_m0_wo0_mtree_add1_3_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 29 => u0_m0_wo0_mtree_add0_6_q(28)) & u0_m0_wo0_mtree_add0_6_q));
    u0_m0_wo0_mtree_add1_3_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 29 => u0_m0_wo0_mtree_add0_7_q(28)) & u0_m0_wo0_mtree_add0_7_q));
    u0_m0_wo0_mtree_add1_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add1_3_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add1_3_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add1_3_a) + SIGNED(u0_m0_wo0_mtree_add1_3_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add1_3_q <= u0_m0_wo0_mtree_add1_3_o(29 downto 0);

    -- u0_m0_wo0_wi0_delayr19(DELAY,29)@10
    u0_m0_wo0_wi0_delayr19 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr18_q, xout => u0_m0_wo0_wi0_delayr19_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_mtree_mult1_11_shift2(BITSHIFT,277)@10
    u0_m0_wo0_mtree_mult1_11_shift2_q_int <= u0_m0_wo0_wi0_delayr19_q & "00000";
    u0_m0_wo0_mtree_mult1_11_shift2_q <= u0_m0_wo0_mtree_mult1_11_shift2_q_int(18 downto 0);

    -- u0_m0_wo0_mtree_mult1_11_sub_3(SUB,278)@10
    u0_m0_wo0_mtree_mult1_11_sub_3_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((19 downto 19 => u0_m0_wo0_mtree_mult1_11_shift2_q(18)) & u0_m0_wo0_mtree_mult1_11_shift2_q));
    u0_m0_wo0_mtree_mult1_11_sub_3_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((19 downto 14 => u0_m0_wo0_wi0_delayr19_q(13)) & u0_m0_wo0_wi0_delayr19_q));
    u0_m0_wo0_mtree_mult1_11_sub_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_11_sub_3_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_11_sub_3_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_11_sub_3_a) - SIGNED(u0_m0_wo0_mtree_mult1_11_sub_3_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_11_sub_3_q <= u0_m0_wo0_mtree_mult1_11_sub_3_o(19 downto 0);

    -- u0_m0_wo0_mtree_mult1_11_shift4(BITSHIFT,279)@11
    u0_m0_wo0_mtree_mult1_11_shift4_q_int <= u0_m0_wo0_mtree_mult1_11_sub_3_q & "0000000";
    u0_m0_wo0_mtree_mult1_11_shift4_q <= u0_m0_wo0_mtree_mult1_11_shift4_q_int(26 downto 0);

    -- u0_m0_wo0_mtree_mult1_11_shift0(BITSHIFT,275)@10
    u0_m0_wo0_mtree_mult1_11_shift0_q_int <= u0_m0_wo0_wi0_delayr19_q & "000";
    u0_m0_wo0_mtree_mult1_11_shift0_q <= u0_m0_wo0_mtree_mult1_11_shift0_q_int(16 downto 0);

    -- u0_m0_wo0_mtree_mult1_11_add_1(ADD,276)@10
    u0_m0_wo0_mtree_mult1_11_add_1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 14 => u0_m0_wo0_wi0_delayr19_q(13)) & u0_m0_wo0_wi0_delayr19_q));
    u0_m0_wo0_mtree_mult1_11_add_1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 17 => u0_m0_wo0_mtree_mult1_11_shift0_q(16)) & u0_m0_wo0_mtree_mult1_11_shift0_q));
    u0_m0_wo0_mtree_mult1_11_add_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_11_add_1_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_11_add_1_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_11_add_1_a) + SIGNED(u0_m0_wo0_mtree_mult1_11_add_1_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_11_add_1_q <= u0_m0_wo0_mtree_mult1_11_add_1_o(17 downto 0);

    -- u0_m0_wo0_mtree_mult1_11_add_5(ADD,280)@11
    u0_m0_wo0_mtree_mult1_11_add_5_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 18 => u0_m0_wo0_mtree_mult1_11_add_1_q(17)) & u0_m0_wo0_mtree_mult1_11_add_1_q));
    u0_m0_wo0_mtree_mult1_11_add_5_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 27 => u0_m0_wo0_mtree_mult1_11_shift4_q(26)) & u0_m0_wo0_mtree_mult1_11_shift4_q));
    u0_m0_wo0_mtree_mult1_11_add_5: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_11_add_5_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_11_add_5_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_11_add_5_a) + SIGNED(u0_m0_wo0_mtree_mult1_11_add_5_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_11_add_5_q <= u0_m0_wo0_mtree_mult1_11_add_5_o(27 downto 0);

    -- u0_m0_wo0_mtree_mult1_11_shift6(BITSHIFT,281)@12
    u0_m0_wo0_mtree_mult1_11_shift6_q_int <= u0_m0_wo0_mtree_mult1_11_add_5_q & "0";
    u0_m0_wo0_mtree_mult1_11_shift6_q <= u0_m0_wo0_mtree_mult1_11_shift6_q_int(28 downto 0);

    -- u0_m0_wo0_wi0_delayr20(DELAY,30)@10
    u0_m0_wo0_wi0_delayr20 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr19_q, xout => u0_m0_wo0_wi0_delayr20_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_mtree_mult1_10(MULT,92)@10
    u0_m0_wo0_mtree_mult1_10_a0 <= STD_LOGIC_VECTOR(u0_m0_wo0_cm10_q);
    u0_m0_wo0_mtree_mult1_10_b0 <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_delayr20_q);
    u0_m0_wo0_mtree_mult1_10_reset <= areset;
    u0_m0_wo0_mtree_mult1_10_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 14,
        lpm_widthb => 14,
        lpm_widthp => 28,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "SIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => u0_m0_wo0_mtree_mult1_10_a0,
        datab => u0_m0_wo0_mtree_mult1_10_b0,
        clken => VCC_q(0),
        aclr => u0_m0_wo0_mtree_mult1_10_reset,
        clock => clk,
        result => u0_m0_wo0_mtree_mult1_10_s1
    );
    u0_m0_wo0_mtree_mult1_10_q <= u0_m0_wo0_mtree_mult1_10_s1;

    -- u0_m0_wo0_mtree_add0_5(ADD,108)@12
    u0_m0_wo0_mtree_add0_5_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_mult1_10_q(27)) & u0_m0_wo0_mtree_mult1_10_q));
    u0_m0_wo0_mtree_add0_5_b <= STD_LOGIC_VECTOR(u0_m0_wo0_mtree_mult1_11_shift6_q);
    u0_m0_wo0_mtree_add0_5: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add0_5_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add0_5_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add0_5_a) + SIGNED(u0_m0_wo0_mtree_add0_5_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add0_5_q <= u0_m0_wo0_mtree_add0_5_o(28 downto 0);

    -- u0_m0_wo0_wi0_delayr21(DELAY,31)@10
    u0_m0_wo0_wi0_delayr21 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr20_q, xout => u0_m0_wo0_wi0_delayr21_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_mtree_mult1_9_shift2(BITSHIFT,292)@10
    u0_m0_wo0_mtree_mult1_9_shift2_q_int <= u0_m0_wo0_wi0_delayr21_q & "0000";
    u0_m0_wo0_mtree_mult1_9_shift2_q <= u0_m0_wo0_mtree_mult1_9_shift2_q_int(17 downto 0);

    -- u0_m0_wo0_mtree_mult1_9_sub_3(SUB,293)@10
    u0_m0_wo0_mtree_mult1_9_sub_3_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 18 => u0_m0_wo0_mtree_mult1_9_shift2_q(17)) & u0_m0_wo0_mtree_mult1_9_shift2_q));
    u0_m0_wo0_mtree_mult1_9_sub_3_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 14 => u0_m0_wo0_wi0_delayr21_q(13)) & u0_m0_wo0_wi0_delayr21_q));
    u0_m0_wo0_mtree_mult1_9_sub_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_9_sub_3_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_9_sub_3_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_9_sub_3_a) - SIGNED(u0_m0_wo0_mtree_mult1_9_sub_3_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_9_sub_3_q <= u0_m0_wo0_mtree_mult1_9_sub_3_o(18 downto 0);

    -- u0_m0_wo0_mtree_mult1_9_shift4(BITSHIFT,294)@11
    u0_m0_wo0_mtree_mult1_9_shift4_q_int <= u0_m0_wo0_mtree_mult1_9_sub_3_q & "000000000";
    u0_m0_wo0_mtree_mult1_9_shift4_q <= u0_m0_wo0_mtree_mult1_9_shift4_q_int(27 downto 0);

    -- u0_m0_wo0_mtree_mult1_9_shift0(BITSHIFT,290)@10
    u0_m0_wo0_mtree_mult1_9_shift0_q_int <= u0_m0_wo0_wi0_delayr21_q & "0000";
    u0_m0_wo0_mtree_mult1_9_shift0_q <= u0_m0_wo0_mtree_mult1_9_shift0_q_int(17 downto 0);

    -- u0_m0_wo0_mtree_mult1_9_sub_1(SUB,291)@10
    u0_m0_wo0_mtree_mult1_9_sub_1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 14 => u0_m0_wo0_wi0_delayr21_q(13)) & u0_m0_wo0_wi0_delayr21_q));
    u0_m0_wo0_mtree_mult1_9_sub_1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 18 => u0_m0_wo0_mtree_mult1_9_shift0_q(17)) & u0_m0_wo0_mtree_mult1_9_shift0_q));
    u0_m0_wo0_mtree_mult1_9_sub_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_9_sub_1_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_9_sub_1_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_9_sub_1_a) - SIGNED(u0_m0_wo0_mtree_mult1_9_sub_1_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_9_sub_1_q <= u0_m0_wo0_mtree_mult1_9_sub_1_o(18 downto 0);

    -- u0_m0_wo0_mtree_mult1_9_add_5(ADD,295)@11
    u0_m0_wo0_mtree_mult1_9_add_5_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 19 => u0_m0_wo0_mtree_mult1_9_sub_1_q(18)) & u0_m0_wo0_mtree_mult1_9_sub_1_q));
    u0_m0_wo0_mtree_mult1_9_add_5_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_mult1_9_shift4_q(27)) & u0_m0_wo0_mtree_mult1_9_shift4_q));
    u0_m0_wo0_mtree_mult1_9_add_5: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_9_add_5_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_9_add_5_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_9_add_5_a) + SIGNED(u0_m0_wo0_mtree_mult1_9_add_5_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_9_add_5_q <= u0_m0_wo0_mtree_mult1_9_add_5_o(28 downto 0);

    -- u0_m0_wo0_wi0_delayr22(DELAY,32)@10
    u0_m0_wo0_wi0_delayr22 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr21_q, xout => u0_m0_wo0_wi0_delayr22_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_mtree_mult1_8(MULT,94)@10
    u0_m0_wo0_mtree_mult1_8_a0 <= STD_LOGIC_VECTOR(u0_m0_wo0_cm8_q);
    u0_m0_wo0_mtree_mult1_8_b0 <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_delayr22_q);
    u0_m0_wo0_mtree_mult1_8_reset <= areset;
    u0_m0_wo0_mtree_mult1_8_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 14,
        lpm_widthb => 14,
        lpm_widthp => 28,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "SIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => u0_m0_wo0_mtree_mult1_8_a0,
        datab => u0_m0_wo0_mtree_mult1_8_b0,
        clken => VCC_q(0),
        aclr => u0_m0_wo0_mtree_mult1_8_reset,
        clock => clk,
        result => u0_m0_wo0_mtree_mult1_8_s1
    );
    u0_m0_wo0_mtree_mult1_8_q <= u0_m0_wo0_mtree_mult1_8_s1;

    -- u0_m0_wo0_mtree_add0_4(ADD,107)@12
    u0_m0_wo0_mtree_add0_4_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_mult1_8_q(27)) & u0_m0_wo0_mtree_mult1_8_q));
    u0_m0_wo0_mtree_add0_4_b <= STD_LOGIC_VECTOR(u0_m0_wo0_mtree_mult1_9_add_5_q);
    u0_m0_wo0_mtree_add0_4: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add0_4_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add0_4_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add0_4_a) + SIGNED(u0_m0_wo0_mtree_add0_4_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add0_4_q <= u0_m0_wo0_mtree_add0_4_o(28 downto 0);

    -- u0_m0_wo0_mtree_add1_2(ADD,120)@13
    u0_m0_wo0_mtree_add1_2_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 29 => u0_m0_wo0_mtree_add0_4_q(28)) & u0_m0_wo0_mtree_add0_4_q));
    u0_m0_wo0_mtree_add1_2_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 29 => u0_m0_wo0_mtree_add0_5_q(28)) & u0_m0_wo0_mtree_add0_5_q));
    u0_m0_wo0_mtree_add1_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add1_2_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add1_2_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add1_2_a) + SIGNED(u0_m0_wo0_mtree_add1_2_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add1_2_q <= u0_m0_wo0_mtree_add1_2_o(29 downto 0);

    -- u0_m0_wo0_mtree_add2_1(ADD,127)@14
    u0_m0_wo0_mtree_add2_1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 30 => u0_m0_wo0_mtree_add1_2_q(29)) & u0_m0_wo0_mtree_add1_2_q));
    u0_m0_wo0_mtree_add2_1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 30 => u0_m0_wo0_mtree_add1_3_q(29)) & u0_m0_wo0_mtree_add1_3_q));
    u0_m0_wo0_mtree_add2_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add2_1_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add2_1_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add2_1_a) + SIGNED(u0_m0_wo0_mtree_add2_1_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add2_1_q <= u0_m0_wo0_mtree_add2_1_o(30 downto 0);

    -- u0_m0_wo0_wi0_delayr23(DELAY,33)@10
    u0_m0_wo0_wi0_delayr23 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr22_q, xout => u0_m0_wo0_wi0_delayr23_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_mtree_mult1_7(MULT,95)@10
    u0_m0_wo0_mtree_mult1_7_a0 <= STD_LOGIC_VECTOR(u0_m0_wo0_cm7_q);
    u0_m0_wo0_mtree_mult1_7_b0 <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_delayr23_q);
    u0_m0_wo0_mtree_mult1_7_reset <= areset;
    u0_m0_wo0_mtree_mult1_7_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 14,
        lpm_widthb => 14,
        lpm_widthp => 28,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "SIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => u0_m0_wo0_mtree_mult1_7_a0,
        datab => u0_m0_wo0_mtree_mult1_7_b0,
        clken => VCC_q(0),
        aclr => u0_m0_wo0_mtree_mult1_7_reset,
        clock => clk,
        result => u0_m0_wo0_mtree_mult1_7_s1
    );
    u0_m0_wo0_mtree_mult1_7_q <= u0_m0_wo0_mtree_mult1_7_s1;

    -- u0_m0_wo0_wi0_delayr24(DELAY,34)@10
    u0_m0_wo0_wi0_delayr24 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr23_q, xout => u0_m0_wo0_wi0_delayr24_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_mtree_mult1_6_shift2(BITSHIFT,316)@10
    u0_m0_wo0_mtree_mult1_6_shift2_q_int <= u0_m0_wo0_wi0_delayr24_q & "000";
    u0_m0_wo0_mtree_mult1_6_shift2_q <= u0_m0_wo0_mtree_mult1_6_shift2_q_int(16 downto 0);

    -- u0_m0_wo0_mtree_mult1_6_sub_3(SUB,317)@10
    u0_m0_wo0_mtree_mult1_6_sub_3_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 17 => u0_m0_wo0_mtree_mult1_6_shift2_q(16)) & u0_m0_wo0_mtree_mult1_6_shift2_q));
    u0_m0_wo0_mtree_mult1_6_sub_3_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 14 => u0_m0_wo0_wi0_delayr24_q(13)) & u0_m0_wo0_wi0_delayr24_q));
    u0_m0_wo0_mtree_mult1_6_sub_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_6_sub_3_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_6_sub_3_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_6_sub_3_a) - SIGNED(u0_m0_wo0_mtree_mult1_6_sub_3_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_6_sub_3_q <= u0_m0_wo0_mtree_mult1_6_sub_3_o(17 downto 0);

    -- u0_m0_wo0_mtree_mult1_6_shift4(BITSHIFT,318)@11
    u0_m0_wo0_mtree_mult1_6_shift4_q_int <= u0_m0_wo0_mtree_mult1_6_sub_3_q & "0000000000";
    u0_m0_wo0_mtree_mult1_6_shift4_q <= u0_m0_wo0_mtree_mult1_6_shift4_q_int(27 downto 0);

    -- u0_m0_wo0_mtree_mult1_6_shift0(BITSHIFT,314)@10
    u0_m0_wo0_mtree_mult1_6_shift0_q_int <= u0_m0_wo0_wi0_delayr24_q & "0000000";
    u0_m0_wo0_mtree_mult1_6_shift0_q <= u0_m0_wo0_mtree_mult1_6_shift0_q_int(20 downto 0);

    -- u0_m0_wo0_mtree_mult1_6_sub_1(SUB,315)@10
    u0_m0_wo0_mtree_mult1_6_sub_1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 14 => u0_m0_wo0_wi0_delayr24_q(13)) & u0_m0_wo0_wi0_delayr24_q));
    u0_m0_wo0_mtree_mult1_6_sub_1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 21 => u0_m0_wo0_mtree_mult1_6_shift0_q(20)) & u0_m0_wo0_mtree_mult1_6_shift0_q));
    u0_m0_wo0_mtree_mult1_6_sub_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_6_sub_1_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_6_sub_1_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_6_sub_1_a) - SIGNED(u0_m0_wo0_mtree_mult1_6_sub_1_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_6_sub_1_q <= u0_m0_wo0_mtree_mult1_6_sub_1_o(21 downto 0);

    -- u0_m0_wo0_mtree_mult1_6_add_5(ADD,319)@11
    u0_m0_wo0_mtree_mult1_6_add_5_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 22 => u0_m0_wo0_mtree_mult1_6_sub_1_q(21)) & u0_m0_wo0_mtree_mult1_6_sub_1_q));
    u0_m0_wo0_mtree_mult1_6_add_5_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_mult1_6_shift4_q(27)) & u0_m0_wo0_mtree_mult1_6_shift4_q));
    u0_m0_wo0_mtree_mult1_6_add_5: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_6_add_5_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_6_add_5_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_mult1_6_add_5_a) + SIGNED(u0_m0_wo0_mtree_mult1_6_add_5_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_6_add_5_q <= u0_m0_wo0_mtree_mult1_6_add_5_o(28 downto 0);

    -- u0_m0_wo0_mtree_add0_3(ADD,106)@12
    u0_m0_wo0_mtree_add0_3_a <= STD_LOGIC_VECTOR(u0_m0_wo0_mtree_mult1_6_add_5_q);
    u0_m0_wo0_mtree_add0_3_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_mult1_7_q(27)) & u0_m0_wo0_mtree_mult1_7_q));
    u0_m0_wo0_mtree_add0_3: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add0_3_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add0_3_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add0_3_a) + SIGNED(u0_m0_wo0_mtree_add0_3_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add0_3_q <= u0_m0_wo0_mtree_add0_3_o(28 downto 0);

    -- u0_m0_wo0_wi0_delayr25(DELAY,35)@10
    u0_m0_wo0_wi0_delayr25 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr24_q, xout => u0_m0_wo0_wi0_delayr25_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_mtree_mult1_5(MULT,97)@10
    u0_m0_wo0_mtree_mult1_5_a0 <= STD_LOGIC_VECTOR(u0_m0_wo0_cm5_q);
    u0_m0_wo0_mtree_mult1_5_b0 <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_delayr25_q);
    u0_m0_wo0_mtree_mult1_5_reset <= areset;
    u0_m0_wo0_mtree_mult1_5_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 14,
        lpm_widthb => 14,
        lpm_widthp => 28,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "SIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => u0_m0_wo0_mtree_mult1_5_a0,
        datab => u0_m0_wo0_mtree_mult1_5_b0,
        clken => VCC_q(0),
        aclr => u0_m0_wo0_mtree_mult1_5_reset,
        clock => clk,
        result => u0_m0_wo0_mtree_mult1_5_s1
    );
    u0_m0_wo0_mtree_mult1_5_q <= u0_m0_wo0_mtree_mult1_5_s1;

    -- u0_m0_wo0_wi0_delayr26(DELAY,36)@10
    u0_m0_wo0_wi0_delayr26 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr25_q, xout => u0_m0_wo0_wi0_delayr26_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_mtree_mult1_4(MULT,98)@10
    u0_m0_wo0_mtree_mult1_4_a0 <= STD_LOGIC_VECTOR(u0_m0_wo0_cm4_q);
    u0_m0_wo0_mtree_mult1_4_b0 <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_delayr26_q);
    u0_m0_wo0_mtree_mult1_4_reset <= areset;
    u0_m0_wo0_mtree_mult1_4_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 14,
        lpm_widthb => 14,
        lpm_widthp => 28,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "SIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => u0_m0_wo0_mtree_mult1_4_a0,
        datab => u0_m0_wo0_mtree_mult1_4_b0,
        clken => VCC_q(0),
        aclr => u0_m0_wo0_mtree_mult1_4_reset,
        clock => clk,
        result => u0_m0_wo0_mtree_mult1_4_s1
    );
    u0_m0_wo0_mtree_mult1_4_q <= u0_m0_wo0_mtree_mult1_4_s1;

    -- u0_m0_wo0_mtree_add0_2(ADD,105)@12
    u0_m0_wo0_mtree_add0_2_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_mult1_4_q(27)) & u0_m0_wo0_mtree_mult1_4_q));
    u0_m0_wo0_mtree_add0_2_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_mult1_5_q(27)) & u0_m0_wo0_mtree_mult1_5_q));
    u0_m0_wo0_mtree_add0_2: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add0_2_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add0_2_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add0_2_a) + SIGNED(u0_m0_wo0_mtree_add0_2_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add0_2_q <= u0_m0_wo0_mtree_add0_2_o(28 downto 0);

    -- u0_m0_wo0_mtree_add1_1(ADD,119)@13
    u0_m0_wo0_mtree_add1_1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 29 => u0_m0_wo0_mtree_add0_2_q(28)) & u0_m0_wo0_mtree_add0_2_q));
    u0_m0_wo0_mtree_add1_1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 29 => u0_m0_wo0_mtree_add0_3_q(28)) & u0_m0_wo0_mtree_add0_3_q));
    u0_m0_wo0_mtree_add1_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add1_1_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add1_1_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add1_1_a) + SIGNED(u0_m0_wo0_mtree_add1_1_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add1_1_q <= u0_m0_wo0_mtree_add1_1_o(29 downto 0);

    -- u0_m0_wo0_wi0_delayr27(DELAY,37)@10
    u0_m0_wo0_wi0_delayr27 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr26_q, xout => u0_m0_wo0_wi0_delayr27_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_mtree_mult1_3(MULT,99)@10
    u0_m0_wo0_mtree_mult1_3_a0 <= STD_LOGIC_VECTOR(u0_m0_wo0_cm3_q);
    u0_m0_wo0_mtree_mult1_3_b0 <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_delayr27_q);
    u0_m0_wo0_mtree_mult1_3_reset <= areset;
    u0_m0_wo0_mtree_mult1_3_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 14,
        lpm_widthb => 14,
        lpm_widthp => 28,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "SIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => u0_m0_wo0_mtree_mult1_3_a0,
        datab => u0_m0_wo0_mtree_mult1_3_b0,
        clken => VCC_q(0),
        aclr => u0_m0_wo0_mtree_mult1_3_reset,
        clock => clk,
        result => u0_m0_wo0_mtree_mult1_3_s1
    );
    u0_m0_wo0_mtree_mult1_3_q <= u0_m0_wo0_mtree_mult1_3_s1;

    -- u0_m0_wo0_wi0_delayr28(DELAY,38)@10
    u0_m0_wo0_wi0_delayr28 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr27_q, xout => u0_m0_wo0_wi0_delayr28_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_mtree_mult1_2(MULT,100)@10
    u0_m0_wo0_mtree_mult1_2_a0 <= STD_LOGIC_VECTOR(u0_m0_wo0_cm2_q);
    u0_m0_wo0_mtree_mult1_2_b0 <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_delayr28_q);
    u0_m0_wo0_mtree_mult1_2_reset <= areset;
    u0_m0_wo0_mtree_mult1_2_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 14,
        lpm_widthb => 14,
        lpm_widthp => 28,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "SIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => u0_m0_wo0_mtree_mult1_2_a0,
        datab => u0_m0_wo0_mtree_mult1_2_b0,
        clken => VCC_q(0),
        aclr => u0_m0_wo0_mtree_mult1_2_reset,
        clock => clk,
        result => u0_m0_wo0_mtree_mult1_2_s1
    );
    u0_m0_wo0_mtree_mult1_2_q <= u0_m0_wo0_mtree_mult1_2_s1;

    -- u0_m0_wo0_mtree_add0_1(ADD,104)@12
    u0_m0_wo0_mtree_add0_1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_mult1_2_q(27)) & u0_m0_wo0_mtree_mult1_2_q));
    u0_m0_wo0_mtree_add0_1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_mult1_3_q(27)) & u0_m0_wo0_mtree_mult1_3_q));
    u0_m0_wo0_mtree_add0_1: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add0_1_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add0_1_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add0_1_a) + SIGNED(u0_m0_wo0_mtree_add0_1_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add0_1_q <= u0_m0_wo0_mtree_add0_1_o(28 downto 0);

    -- u0_m0_wo0_wi0_delayr29(DELAY,39)@10
    u0_m0_wo0_wi0_delayr29 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr28_q, xout => u0_m0_wo0_wi0_delayr29_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_mtree_mult1_1(MULT,101)@10
    u0_m0_wo0_mtree_mult1_1_a0 <= STD_LOGIC_VECTOR(u0_m0_wo0_cm1_q);
    u0_m0_wo0_mtree_mult1_1_b0 <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_delayr29_q);
    u0_m0_wo0_mtree_mult1_1_reset <= areset;
    u0_m0_wo0_mtree_mult1_1_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 14,
        lpm_widthb => 14,
        lpm_widthp => 28,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "SIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => u0_m0_wo0_mtree_mult1_1_a0,
        datab => u0_m0_wo0_mtree_mult1_1_b0,
        clken => VCC_q(0),
        aclr => u0_m0_wo0_mtree_mult1_1_reset,
        clock => clk,
        result => u0_m0_wo0_mtree_mult1_1_s1
    );
    u0_m0_wo0_mtree_mult1_1_q <= u0_m0_wo0_mtree_mult1_1_s1;

    -- u0_m0_wo0_wi0_delayr30(DELAY,40)@10
    u0_m0_wo0_wi0_delayr30 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1 )
    PORT MAP ( xin => u0_m0_wo0_wi0_delayr29_q, xout => u0_m0_wo0_wi0_delayr30_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_mtree_mult1_0(MULT,102)@10
    u0_m0_wo0_mtree_mult1_0_a0 <= STD_LOGIC_VECTOR(u0_m0_wo0_cm0_q);
    u0_m0_wo0_mtree_mult1_0_b0 <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_delayr30_q);
    u0_m0_wo0_mtree_mult1_0_reset <= areset;
    u0_m0_wo0_mtree_mult1_0_component : lpm_mult
    GENERIC MAP (
        lpm_widtha => 14,
        lpm_widthb => 14,
        lpm_widthp => 28,
        lpm_widths => 1,
        lpm_type => "LPM_MULT",
        lpm_representation => "SIGNED",
        lpm_hint => "DEDICATED_MULTIPLIER_CIRCUITRY=YES, MAXIMIZE_SPEED=5",
        lpm_pipeline => 2
    )
    PORT MAP (
        dataa => u0_m0_wo0_mtree_mult1_0_a0,
        datab => u0_m0_wo0_mtree_mult1_0_b0,
        clken => VCC_q(0),
        aclr => u0_m0_wo0_mtree_mult1_0_reset,
        clock => clk,
        result => u0_m0_wo0_mtree_mult1_0_s1
    );
    u0_m0_wo0_mtree_mult1_0_q <= u0_m0_wo0_mtree_mult1_0_s1;

    -- u0_m0_wo0_mtree_add0_0(ADD,103)@12
    u0_m0_wo0_mtree_add0_0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_mult1_0_q(27)) & u0_m0_wo0_mtree_mult1_0_q));
    u0_m0_wo0_mtree_add0_0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_mult1_1_q(27)) & u0_m0_wo0_mtree_mult1_1_q));
    u0_m0_wo0_mtree_add0_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add0_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add0_0_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add0_0_a) + SIGNED(u0_m0_wo0_mtree_add0_0_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add0_0_q <= u0_m0_wo0_mtree_add0_0_o(28 downto 0);

    -- u0_m0_wo0_mtree_add1_0(ADD,118)@13
    u0_m0_wo0_mtree_add1_0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 29 => u0_m0_wo0_mtree_add0_0_q(28)) & u0_m0_wo0_mtree_add0_0_q));
    u0_m0_wo0_mtree_add1_0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 29 => u0_m0_wo0_mtree_add0_1_q(28)) & u0_m0_wo0_mtree_add0_1_q));
    u0_m0_wo0_mtree_add1_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add1_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add1_0_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add1_0_a) + SIGNED(u0_m0_wo0_mtree_add1_0_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add1_0_q <= u0_m0_wo0_mtree_add1_0_o(29 downto 0);

    -- u0_m0_wo0_mtree_add2_0(ADD,126)@14
    u0_m0_wo0_mtree_add2_0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 30 => u0_m0_wo0_mtree_add1_0_q(29)) & u0_m0_wo0_mtree_add1_0_q));
    u0_m0_wo0_mtree_add2_0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 30 => u0_m0_wo0_mtree_add1_1_q(29)) & u0_m0_wo0_mtree_add1_1_q));
    u0_m0_wo0_mtree_add2_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add2_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add2_0_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add2_0_a) + SIGNED(u0_m0_wo0_mtree_add2_0_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add2_0_q <= u0_m0_wo0_mtree_add2_0_o(30 downto 0);

    -- u0_m0_wo0_mtree_add3_0(ADD,130)@15
    u0_m0_wo0_mtree_add3_0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((31 downto 31 => u0_m0_wo0_mtree_add2_0_q(30)) & u0_m0_wo0_mtree_add2_0_q));
    u0_m0_wo0_mtree_add3_0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((31 downto 31 => u0_m0_wo0_mtree_add2_1_q(30)) & u0_m0_wo0_mtree_add2_1_q));
    u0_m0_wo0_mtree_add3_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add3_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add3_0_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add3_0_a) + SIGNED(u0_m0_wo0_mtree_add3_0_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add3_0_q <= u0_m0_wo0_mtree_add3_0_o(31 downto 0);

    -- u0_m0_wo0_mtree_add4_0(ADD,132)@16
    u0_m0_wo0_mtree_add4_0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 32 => u0_m0_wo0_mtree_add3_0_q(31)) & u0_m0_wo0_mtree_add3_0_q));
    u0_m0_wo0_mtree_add4_0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 32 => u0_m0_wo0_mtree_add3_1_q(31)) & u0_m0_wo0_mtree_add3_1_q));
    u0_m0_wo0_mtree_add4_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add4_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add4_0_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add4_0_a) + SIGNED(u0_m0_wo0_mtree_add4_0_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add4_0_q <= u0_m0_wo0_mtree_add4_0_o(32 downto 0);

    -- GND(CONSTANT,0)@0
    GND_q <= "0";

    -- d_u0_m0_wo0_compute_q_16(DELAY,709)@10
    d_u0_m0_wo0_compute_q_16 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6 )
    PORT MAP ( xin => xIn_v, xout => d_u0_m0_wo0_compute_q_16_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_oseq_gated_reg(REG,133)@16
    u0_m0_wo0_oseq_gated_reg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_oseq_gated_reg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_oseq_gated_reg_q <= STD_LOGIC_VECTOR(d_u0_m0_wo0_compute_q_16_q);
        END IF;
    END PROCESS;

    -- xOut(PORTOUT,138)@17
    xOut_v <= u0_m0_wo0_oseq_gated_reg_q;
    xOut_c <= STD_LOGIC_VECTOR("0000000" & GND_q);
    xOut_0 <= u0_m0_wo0_mtree_add4_0_q;

END normal;
