vlog +acc ../TB/Top/SPI_Top.sv
set test_name spi_Full_duplex_test
vsim -debugdb=+acc -onfinish stop -assertdebug work.top +UVM_VERBOSITY=UVM_LOW +UVM_TESTNAME=$test_name
add wave -position insertpoint /top/dut/PCLK
add wave -position insertpoint /top/dut/PRESETN
add wave -position insertpoint /top/dut/PSEL
add wave -position insertpoint /top/dut/PENABLE
add wave -position insertpoint /top/dut/PWRITE
add wave -position insertpoint /top/dut/PADDR
add wave -position insertpoint /top/dut/PWDATA
add wave -position insertpoint /top/dut/MISO_IN
add wave -position insertpoint /top/dut/MISO_OUT
add wave -position insertpoint /top/dut/PRDATA
add wave -position insertpoint sim:/top/dut/top/apb_slave/SPI_CR1
add wave -position insertpoint sim:/top/dut/top/apb_slave/SPI_CR2
add wave -position insertpoint sim:/top/dut/top/apb_slave/SPI_SR
add wave -position insertpoint sim:/top/dut/top/apb_slave/SPI_DR_TX
add wave -position insertpoint sim:/top/dut/top/apb_slave/SPI_DR_RX
add wave -position insertpoint sim:/top/dut/top/apb_slave/TX_BUFFER
add wave -position insertpoint sim:/top/dut/top/apb_slave/RX_BUFFER
add wave -position insertpoint sim:/top/dut/top/TXE_flag/EMPTY
add wave -position insertpoint sim:/top/dut/top/TXE_flag/FULL
add wave -position insertpoint sim:/top/dut/top/TXE_flag/DATA_OUT
add wave -position insertpoint sim:/top/dut/top/TXE_flag/DATA_IN
add wave -position insertpoint sim:/top/dut/top/master/SHIFT_REGISTER_DFF_TX
add wave -position insertpoint sim:/top/dut/top/master/SHIFT_REGISTER_DFF_RX
add wave -position insertpoint sim:/top/dut/top/master/SHIFT_REGISTER_TX
add wave -position insertpoint sim:/top/dut/top/master/SHIFT_REGISTER_RX
add wave -position insertpoint sim:/top/dut/top/master/RD_EN
add wave -position insertpoint sim:/top/dut/top/master/WR_EN
add wave -position insertpoint sim:/top/dut/top/WRITE_TX_BUFFER
add wave -position insertpoint sim:/top/dut/top/RX_BUFFER_OUT
add wave -position insertpoint sim:/top/dut/top/apb_slave/SPI_WRITE
add wave -position insertpoint sim:/top/dut/top/apb_slave/SPI_READ
add wave -position insertpoint /top/dut/top/master/SCK
add wave -position insertpoint /top/dut/top/master/RX_BUFFER
add wave -position insertpoint /top/dut/top/master/TX_BUFFER
add wave -position insertpoint /top/dut/PREADY
add wave -position insertpoint /top/dut/PSLVERR
add wave -position insertpoint /top/dut/MOSI_IN
add wave -position insertpoint /top/dut/MOSI_OUT
add wave -position insertpoint /top/intf/PREADY
add wave -position insertpoint /top/intf/PSLVERR
add wave -position insertpoint /top/intf/MOSI_IN
add wave -position insertpoint /top/intf/MOSI_OUT
add wave -position insertpoint /top/intf/PRESETN
add wave -position insertpoint /top/intf/PADDR
add wave -position insertpoint /top/intf/PSEL
add wave -position insertpoint /top/intf/PWDATA
add wave -position insertpoint /top/intf/PWRITE
add wave -position insertpoint /top/intf/MISO_IN
add wave -position insertpoint /top/intf/MISO_OUT
add wave -position insertpoint /top/intf/PRDATA
add wave -position insertpoint /top/intf/PENABLE
add wave -position insertpoint sim:/top/dut/top/apb_slave/BIDIMODE
add wave -position insertpoint sim:/top/dut/top/apb_slave/BIDIOE
add wave -position insertpoint sim:/top/dut/top/apb_slave/CRCEN
add wave -position insertpoint sim:/top/dut/top/apb_slave/CRCNEXT
add wave -position insertpoint sim:/top/dut/top/apb_slave/DFF
add wave -position insertpoint sim:/top/dut/top/apb_slave/RXONLY
add wave -position insertpoint sim:/top/dut/top/apb_slave/SSM
add wave -position insertpoint sim:/top/dut/top/apb_slave/SSI
add wave -position insertpoint sim:/top/dut/top/apb_slave/LSBFIRST
add wave -position insertpoint sim:/top/dut/top/apb_slave/SPE
add wave -position insertpoint sim:/top/dut/top/apb_slave/BR
add wave -position insertpoint sim:/top/dut/top/apb_slave/MSTR
add wave -position insertpoint sim:/top/dut/top/apb_slave/CPOL
add wave -position insertpoint sim:/top/dut/top/apb_slave/CPHA
add wave -position insertpoint sim:/top/dut/top/apb_slave/TXEIE
add wave -position insertpoint sim:/top/dut/top/apb_slave/RXNEIE
add wave -position insertpoint sim:/top/dut/top/apb_slave/ERRIE
add wave -position insertpoint sim:/top/dut/top/apb_slave/SSOE
add wave -position insertpoint sim:/top/dut/top/apb_slave/TXDMAEN
add wave -position insertpoint sim:/top/dut/top/apb_slave/RXDMAEN
add wave -position insertpoint sim:/top/dut/top/apb_slave/BSY
add wave -position insertpoint sim:/top/dut/top/apb_slave/OVR
add wave -position insertpoint sim:/top/dut/top/apb_slave/MODF
add wave -position insertpoint sim:/top/dut/top/apb_slave/CRCERR
add wave -position insertpoint sim:/top/dut/top/apb_slave/UDR
add wave -position insertpoint sim:/top/dut/top/apb_slave/CHSIDE
add wave -position insertpoint sim:/top/dut/top/apb_slave/TXE
add wave -position insertpoint sim:/top/dut/top/apb_slave/RXNE
view assertions
run -all



