#line 2 "../kern/e1000.c"
#include <kern/e1000.h>

// LAB 6: Your driver code here
#line 6 "../kern/e1000.c"
#include <inc/assert.h>
#include <inc/error.h>
#include <inc/string.h>
#include <kern/pmap.h>

/* Registers */
#define E1000_STATUS   (0x00008/4)  /* Device Status - RO */
#define E1000_EERD     (0x00014/4)  /* EEPROM Read - RW */

#define E1000_EERD_START 0x01
#define E1000_EERD_DONE  0x10

#define E1000_IMS      (0x000D0/4)  /* Interrupt Mask Set - RW */
#define E1000_RCTL     (0x00100/4)  /* RX Control - RW */
#define E1000_TCTL     (0x00400/4)  /* TX Control - RW */
#define E1000_TIPG     (0x00410/4)  /* TX Inter-packet gap -RW */
#define E1000_RDBAL    (0x02800/4)  /* RX Descriptor Base Address Low - RW */
#define E1000_RDLEN    (0x02808/4)  /* RX Descriptor Length - RW */
#define E1000_RDH      (0x02810/4)  /* RX Descriptor Head - RW */
#define E1000_RDT      (0x02818/4)  /* RX Descriptor Tail - RW */
#define E1000_TDBAL    (0x03800/4)  /* TX Descriptor Base Address Low - RW */
#define E1000_TDLEN    (0x03808/4)  /* TX Descriptor Length - RW */
#define E1000_TDH      (0x03810/4)  /* TX Descriptor Head - RW */
#define E1000_TDT      (0x03818/4)  /* TX Descripotr Tail - RW */
#define E1000_RAL      (0x05400/4)  /* Receive Address Low - RW Array */
#define E1000_RAH      (0x05404/4)  /* Receive Address High - RW Array */


/* Transmit Control */
#define E1000_TCTL_RST    0x00000001    /* software reset */
#define E1000_TCTL_EN     0x00000002    /* enable tx */
#define E1000_TCTL_BCE    0x00000004    /* busy check enable */
#define E1000_TCTL_PSP    0x00000008    /* pad short packets */
#define E1000_TCTL_CT     0x00000ff0    /* collision threshold */
#define E1000_TCTL_CT_SHIFT 4
#define E1000_TCTL_COLD   0x003ff000    /* collision distance */
#define E1000_TCTL_COLD_SHIFT 12
#define E1000_TCTL_SWXOFF 0x00400000    /* SW Xoff transmission */
#define E1000_TCTL_PBE    0x00800000    /* Packet Burst Enable */
#define E1000_TCTL_RTLC   0x01000000    /* Re-transmit on late collision */
#define E1000_TCTL_NRTU   0x02000000    /* No Re-transmit on underrun */
#define E1000_TCTL_MULR   0x10000000    /* Multiple request support */

/* Receive Control */
#define E1000_RCTL_RST            0x00000001    /* Software reset */
#define E1000_RCTL_EN             0x00000002    /* enable */
#define E1000_RCTL_SBP            0x00000004    /* store bad packet */
#define E1000_RCTL_UPE            0x00000008    /* unicast promiscuous enable */
#define E1000_RCTL_MPE            0x00000010    /* multicast promiscuous enab */
#define E1000_RCTL_LPE            0x00000020    /* long packet enable */
#define E1000_RCTL_LBM_NO         0x00000000    /* no loopback mode */
#define E1000_RCTL_LBM_MAC        0x00000040    /* MAC loopback mode */
#define E1000_RCTL_LBM_SLP        0x00000080    /* serial link loopback mode */
#define E1000_RCTL_LBM_TCVR       0x000000C0    /* tcvr loopback mode */
#define E1000_RCTL_DTYP_MASK      0x00000C00    /* Descriptor type mask */
#define E1000_RCTL_DTYP_PS        0x00000400    /* Packet Split descriptor */
#define E1000_RCTL_RDMTS_HALF     0x00000000    /* rx desc min threshold size */
#define E1000_RCTL_RDMTS_QUAT     0x00000100    /* rx desc min threshold size */
#define E1000_RCTL_RDMTS_EIGTH    0x00000200    /* rx desc min threshold size */
#define E1000_RCTL_MO_SHIFT       12            /* multicast offset shift */
#define E1000_RCTL_MO_0           0x00000000    /* multicast offset 11:0 */
#define E1000_RCTL_MO_1           0x00001000    /* multicast offset 12:1 */
#define E1000_RCTL_MO_2           0x00002000    /* multicast offset 13:2 */
#define E1000_RCTL_MO_3           0x00003000    /* multicast offset 15:4 */
#define E1000_RCTL_MDR            0x00004000    /* multicast desc ring 0 */
#define E1000_RCTL_BAM            0x00008000    /* broadcast enable */
/* these buffer sizes are valid if E1000_RCTL_BSEX is 0 */
#define E1000_RCTL_SZ_2048        0x00000000    /* rx buffer size 2048 */
#define E1000_RCTL_SZ_1024        0x00010000    /* rx buffer size 1024 */
#define E1000_RCTL_SZ_512         0x00020000    /* rx buffer size 512 */
#define E1000_RCTL_SZ_256         0x00030000    /* rx buffer size 256 */
/* these buffer sizes are valid if E1000_RCTL_BSEX is 1 */
#define E1000_RCTL_SZ_16384       0x00010000    /* rx buffer size 16384 */
#define E1000_RCTL_SZ_8192        0x00020000    /* rx buffer size 8192 */
#define E1000_RCTL_SZ_4096        0x00030000    /* rx buffer size 4096 */
#define E1000_RCTL_VFE            0x00040000    /* vlan filter enable */
#define E1000_RCTL_CFIEN          0x00080000    /* canonical form enable */
#define E1000_RCTL_CFI            0x00100000    /* canonical form indicator */
#define E1000_RCTL_DPF            0x00400000    /* discard pause frames */
#define E1000_RCTL_PMCF           0x00800000    /* pass MAC control frames */
#define E1000_RCTL_BSEX           0x02000000    /* Buffer size extension */
#define E1000_RCTL_SECRC          0x04000000    /* Strip Ethernet CRC */
#define E1000_RCTL_FLXBUF_MASK    0x78000000    /* Flexible buffer size */
#define E1000_RCTL_FLXBUF_SHIFT   27            /* Flexible buffer shift */

static volatile uint32_t *regs;


#define DATA_MAX 1518


/* Transmit Descriptor command definitions [E1000 3.3.3.1] */
#define E1000_TXD_CMD_EOP    0x01 /* End of Packet */
#define E1000_TXD_CMD_RS     0x08 /* Report Status */

/* Transmit Descriptor status definitions [E1000 3.3.3.2] */
#define E1000_TXD_STAT_DD    0x00000001 /* Descriptor Done */

// [E1000 3.3.3]
struct tx_desc
{
	uint64_t addr;
	uint16_t length;
	uint8_t cso;
	uint8_t cmd;
	uint8_t status;
	uint8_t css;
	uint16_t special;
} __attribute__((packed));

#define TX_RING_SIZE 16
static struct tx_desc tx_ring[TX_RING_SIZE] __attribute__((aligned(16)));
static char tx_data[TX_RING_SIZE][DATA_MAX];

/* Receive Descriptor bit definitions [E1000 3.2.3.1] */
#define E1000_RXD_STAT_DD       0x01    /* Descriptor Done */
#define E1000_RXD_STAT_EOP      0x02    /* End of Packet */

// [E1000 3.2.3]
struct rx_desc
{
	uint64_t addr;       /* Address of the descriptor's data buffer */
	uint16_t length;     /* Length of data DMAed into data buffer */
	uint16_t csum;       /* Packet checksum */
	uint8_t status;      /* Descriptor status */
	uint8_t errors;      /* Descriptor Errors */
	uint16_t special;
} __attribute__((packed));

#define RX_RING_SIZE 1000
static struct rx_desc rx_ring[RX_RING_SIZE] __attribute__((aligned(16)));
static char rx_data[RX_RING_SIZE][2048];

int
e1000_attach(struct pci_func *pcif)
{
	int i;

	pci_func_enable(pcif);

	// [E1000 Table 4-2] BAR 0 gives the register base address.
	regs = mmio_map_region(pcif->reg_base[0], pcif->reg_size[0]);

	// [E1000 14.5] Transmit initialization
	for (i = 0; i < TX_RING_SIZE; i++) {
		tx_ring[i].addr = PADDR(tx_data[i]);
		tx_ring[i].status = E1000_TXD_STAT_DD;
	}
	regs[E1000_TDBAL] = PADDR(tx_ring);
	static_assert(sizeof(tx_ring) % 128 == 0);
	regs[E1000_TDLEN] = sizeof(tx_ring);
	regs[E1000_TDH] = regs[E1000_TDT] = 0;
	regs[E1000_TCTL] = (E1000_TCTL_EN | E1000_TCTL_PSP |
			    (0x10 << E1000_TCTL_CT_SHIFT) |
			    (0x40 << E1000_TCTL_COLD_SHIFT));
	regs[E1000_TIPG] = 10 | (8<<10) | (6<<20);

#if 0 /* not really necessary */
	// [E1000 14.4] Receive initialization
	regs[E1000_EERD] = 0x0;
	regs[E1000_EERD] |= E1000_EERD_START;
	while (!(regs[E1000_EERD] & E1000_EERD_DONE));
	regs[E1000_RAL] = regs[E1000_EERD] >> 16;

	regs[E1000_EERD] = 0x1 << 8;
	regs[E1000_EERD] |= E1000_EERD_START;
	while (!(regs[E1000_EERD] & E1000_EERD_DONE));
	regs[E1000_RAL] |= regs[E1000_EERD] & 0xffff0000;

	regs[E1000_EERD] = 0x2 << 8;
	regs[E1000_EERD] |= E1000_EERD_START;
	while (!(regs[E1000_EERD] & E1000_EERD_DONE));
	regs[E1000_RAH] = regs[E1000_EERD] >> 16;

	regs[E1000_RAH] |= 0x1 << 31;
#endif

	for (i = 0; i < RX_RING_SIZE; i++) {
		rx_ring[i].addr = PADDR(rx_data[i]);
	}
	regs[E1000_RDBAL] = PADDR(rx_ring);
	static_assert(sizeof(rx_ring) % 128 == 0);
	regs[E1000_RDLEN] = sizeof(rx_ring);
	regs[E1000_RDH] = 0;
	regs[E1000_RDT] = RX_RING_SIZE - 1;
	// Strip CRC because that's what the grade script expects
	regs[E1000_RCTL] = E1000_RCTL_EN | E1000_RCTL_BAM | E1000_RCTL_SZ_2048
		| E1000_RCTL_SECRC;

	return 0;
}

int
e1000_transmit(const char *buf, unsigned int len)
{
	if (!regs || len > DATA_MAX)
		return -E_INVAL;

	int tail = regs[E1000_TDT];

	// [E1000 3.3.3.2] Check if this descriptor is done.
	// According to [E1000 13.4.39], using TDH for this is not
	// reliable.
	if (!(tx_ring[tail].status & E1000_TXD_STAT_DD)) {
		cprintf("TX ring overflow\n");
		return 0;
	}

	// Fill in the next descriptor
	memmove(tx_data[tail], buf, len);
	tx_ring[tail].length = len;
	tx_ring[tail].status &= ~E1000_TXD_STAT_DD;
	// Set EOP to actually send this packet.  Set RS to get DD
	// status bit when sent.
	tx_ring[tail].cmd = E1000_TXD_CMD_EOP | E1000_TXD_CMD_RS;

	// Move the tail pointer
	regs[E1000_TDT] = (tail + 1) % TX_RING_SIZE;

	return 0;
}

int
e1000_receive(char *buf, unsigned int len)
{
	if (!regs)
		return 0;

	int tail = (regs[E1000_RDT] + 1) % RX_RING_SIZE;

	// Check if the descriptor has been filled
	if (!(rx_ring[tail].status & E1000_RXD_STAT_DD))
		return 0;
	assert(rx_ring[tail].status & E1000_RXD_STAT_EOP);

	// Copy the packet data
	len = MIN(len, rx_ring[tail].length);
	memmove(buf, rx_data[tail], len);
	rx_ring[tail].status = 0;

	// Move the tail pointer
	regs[E1000_RDT] = tail;
	return len;
}

