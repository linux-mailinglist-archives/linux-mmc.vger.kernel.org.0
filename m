Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2457728836D
	for <lists+linux-mmc@lfdr.de>; Fri,  9 Oct 2020 09:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731824AbgJIHZc (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 9 Oct 2020 03:25:32 -0400
Received: from mail-co1nam11on2051.outbound.protection.outlook.com ([40.107.220.51]:48993
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbgJIHZb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 9 Oct 2020 03:25:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZHwp/YlCgDg6TUOGCkxWcewW//48Cpypj/yBCjepK3T0J1HA/qDkoPlK2JTJnBrEpu8XkdzUOgMEwxbZtwZQPA3X6YqzoV8Z1ZkdzyKsc3hj/nLvRWBj7l/utxGWmq3HJeEioBFL83P4BVmMmvf7h7qsys7aPwmKMlkeD01gm7uasJkLr2XNBKuxPE3whNQ/SWC07vusYCmfsyI+WnLHnXOIoQI20JsK+OtCVt6gTsMyUnXxUHYc0SWyakZ6NRMD0rFCPoRjtAvpxXAUzgfwJC8wYnjumNiGBPYN+mvFwFdvTEahGtxCKr5xqDpFHa86iT4gm5tJ1+Nrut9M2A6uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdX9LocjlTY3JS4gr1m4NWHiG9yFrCqBsPcOmvygCn4=;
 b=FKN/n6s+knks8ZYicfUBXXO1kW6EwTdOpIYYLlpVsoBT8RTo+b+doEYdo7yC8DLryfwhrcYmTbAetwgUTqWUYxDI3Bq7NfZMUaInTrBhIiqQrlhIvI8NGd5cLHds2W3KEoIArCYJBjzyP1YmWybB9U/nxt6XphD4cyQc65rBrdV6wcUhQ5R8IrATl7StV1TBARZvsHqPoJTcicYL5otva0UcsB7TXc6RWnqsN04IYzg+Uvnv/czcNLZP4jUEe1AKTeiAXsEUGYM65UXe1Y9dbcAzx7paoML2/dnCu68sDSMx162Xd1elRXFJGTNIfV/XS3SPM5mstapW+taKrA6h6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdX9LocjlTY3JS4gr1m4NWHiG9yFrCqBsPcOmvygCn4=;
 b=OIx0+eT2T92UB8is1lveJ73o6OZm7LlErztijYxEiDzv2AtsbaXq57DnnqH+ibwSfD0SFN95VofefPixy+ZeI4g6zWBaC/yPxNtvSx5YEk0GNhoka2Od4BF9AJxxT6aPadnhvVNeDBL6agIbXQ1lTK5p0s5u5nPPfoWeCDZ1ViU=
Received: from DM5PR04CA0057.namprd04.prod.outlook.com (2603:10b6:3:ef::19) by
 BN7PR02MB4018.namprd02.prod.outlook.com (2603:10b6:406:ff::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.24; Fri, 9 Oct 2020 07:25:26 +0000
Received: from CY1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:ef:cafe::40) by DM5PR04CA0057.outlook.office365.com
 (2603:10b6:3:ef::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22 via Frontend
 Transport; Fri, 9 Oct 2020 07:25:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT028.mail.protection.outlook.com (10.152.75.132) with Microsoft SMTP
 Server id 15.20.3455.25 via Frontend Transport; Fri, 9 Oct 2020 07:25:26
 +0000
Received: from [149.199.38.66] (port=53981 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kQmlj-0005ih-Fw; Fri, 09 Oct 2020 00:24:47 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kQmmM-0003u7-3c; Fri, 09 Oct 2020 00:25:26 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 0997PF4E006007;
        Fri, 9 Oct 2020 00:25:15 -0700
Received: from [172.30.17.110]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1kQmmB-0003qf-3g; Fri, 09 Oct 2020 00:25:15 -0700
Subject: Re: [PATCH v4 4/4] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
Cc:     "Hunter, Adrian" <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20201008020936.19894-1-muhammad.husaini.zulkifli@intel.com>
 <20201008020936.19894-5-muhammad.husaini.zulkifli@intel.com>
 <CAPDyKFpUv8yeVrWVLRKvz4eKsSDdk0y4dKY2mYs07zpA2UqNdw@mail.gmail.com>
 <DM6PR11MB28764EC5E1F89D417D700F29B80B0@DM6PR11MB2876.namprd11.prod.outlook.com>
 <CAPDyKFptgKG8uvKUkN56sooFL4xqaBcNdbpo645xRQqPOH4BkQ@mail.gmail.com>
 <DM6PR11MB28761F10936FF0D2695FAF19B80B0@DM6PR11MB2876.namprd11.prod.outlook.com>
 <CAPDyKFoRHsOiz9BFJ5jWyKqvdmNW9eeEmCGKYn0Q1jUzNwJZNg@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Autocrypt: addr=michals@xilinx.com; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <d52adf5a-56e6-470f-a365-36a3bed0f719@xilinx.com>
Date:   Fri, 9 Oct 2020 09:25:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoRHsOiz9BFJ5jWyKqvdmNW9eeEmCGKYn0Q1jUzNwJZNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64c2e2d3-12e5-4b02-7d73-08d86c247e2e
X-MS-TrafficTypeDiagnostic: BN7PR02MB4018:
X-Microsoft-Antispam-PRVS: <BN7PR02MB40188F9E39989122D54712F5C6080@BN7PR02MB4018.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: owYYCosSgnmD+n+IXSnFKkjC5d64pGHOYJ7F4WSAK9nORTfGdm7BCTrtSubchXKn6KdQZdOHgKf/1u15GKge0tVI5eMduI0oQRNSCK31cO9hnJ6dL5EXxo7BCaoFq30oS27BIhDK0sAT87UE2SVUtKjdEItTyq60t5I9hbZ6lVmMqZ/iW2fzI2bMKqe7N129yLeO4OvwO4mn3FztTgnx/frROFcTcy4ym28cusu+5lu4dO9yFO0qSja0c/30r+zigpKPTM3zkI7xrL5fU1kiD2d+xMtwMUzi+abx5OkYliQFptP3CMLAIrQRBX3HJCB4E5q9uOm8zUF94ydi0pVtAuJ7Te0+muQlVZclV8KywqpzAQYslbIDYgbk/q2EkLflQsLw0wQPaftT5z9qUK6wRcunu/jG9/xu4k7qM8Rz8wSzPoc6rpZ5wuWQeVlDLzlL2stSRenKoBahcrmdlQDSETGb3srE0WthK5qnXbXZbXrGFP6jEucP2Vz8UbsCdATX
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(39860400002)(346002)(396003)(376002)(136003)(46966005)(5660300002)(4326008)(356005)(81166007)(83080400001)(7416002)(36756003)(8676002)(8936002)(9786002)(83380400001)(2906002)(70586007)(82740400003)(53546011)(316002)(966005)(31686004)(336012)(26005)(44832011)(82310400003)(110136005)(426003)(47076004)(70206006)(478600001)(2616005)(54906003)(186003)(6666004)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 07:25:26.4393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c2e2d3-12e5-4b02-7d73-08d86c247e2e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT028.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4018
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 09. 10. 20 8:56, Ulf Hansson wrote:
> On Thu, 8 Oct 2020 at 19:21, Zulkifli, Muhammad Husaini
> <muhammad.husaini.zulkifli@intel.com> wrote:
>>
>> Hi,
>>
>>> -----Original Message-----
>>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>> Sent: Thursday, October 8, 2020 11:19 PM
>>> To: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>
>>> Cc: Hunter, Adrian <adrian.hunter@intel.com>; Michal Simek
>>> <michal.simek@xilinx.com>; Shevchenko, Andriy
>>> <andriy.shevchenko@intel.com>; linux-mmc@vger.kernel.org; Linux ARM
>>> <linux-arm-kernel@lists.infradead.org>; Linux Kernel Mailing List <linux-
>>> kernel@vger.kernel.org>; Raja Subramanian, Lakshmi Bai
>>> <lakshmi.bai.raja.subramanian@intel.com>; Wan Mohamad, Wan Ahmad
>>> Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>; Arnd Bergmann
>>> <arnd@arndb.de>
>>> Subject: Re: [PATCH v4 4/4] mmc: sdhci-of-arasan: Enable UHS-1 support for
>>> Keem Bay SOC
>>>
>>> On Thu, 8 Oct 2020 at 12:54, Zulkifli, Muhammad Husaini
>>> <muhammad.husaini.zulkifli@intel.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>>> -----Original Message-----
>>>>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>>>> Sent: Thursday, October 8, 2020 5:28 PM
>>>>> To: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>
>>>>> Cc: Hunter, Adrian <adrian.hunter@intel.com>; Michal Simek
>>>>> <michal.simek@xilinx.com>; Shevchenko, Andriy
>>>>> <andriy.shevchenko@intel.com>; linux-mmc@vger.kernel.org; Linux ARM
>>>>> <linux-arm-kernel@lists.infradead.org>; Linux Kernel Mailing List
>>>>> <linux- kernel@vger.kernel.org>; Raja Subramanian, Lakshmi Bai
>>>>> <lakshmi.bai.raja.subramanian@intel.com>; Wan Mohamad, Wan Ahmad
>>>>> Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>; Arnd Bergmann
>>>>> <arnd@arndb.de>
>>>>> Subject: Re: [PATCH v4 4/4] mmc: sdhci-of-arasan: Enable UHS-1
>>>>> support for Keem Bay SOC
>>>>>
>>>>> On Thu, 8 Oct 2020 at 04:12, <muhammad.husaini.zulkifli@intel.com>
>>> wrote:
>>>>>>
>>>>>> From: Muhammad Husaini Zulkifli
>>>>>> <muhammad.husaini.zulkifli@intel.com>
>>>>>>
>>>>>> Voltage switching sequence is needed to support UHS-1 interface.
>>>>>> There are 2 places to control the voltage.
>>>>>> 1) By setting the AON register using firmware driver calling
>>>>>> system-level platform management layer (SMC) to set the register.
>>>>>> 2) By controlling the GPIO expander value to drive either 1.8V or
>>>>>> 3.3V for power mux input.
>>>>>>
>>>>>> Signed-off-by: Muhammad Husaini Zulkifli
>>>>>> <muhammad.husaini.zulkifli@intel.com>
>>>>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>>>>>> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
>>>>>> ---
>>>>>>  drivers/mmc/host/sdhci-of-arasan.c | 126
>>>>>> +++++++++++++++++++++++++++++
>>>>>>  1 file changed, 126 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c
>>>>>> b/drivers/mmc/host/sdhci-of-arasan.c
>>>>>> index 46aea6516133..ea2467b0073d 100644
>>>>>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>>>>>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>>>>>> @@ -16,6 +16,7 @@
>>>>>>   */
>>>>>>
>>>>>>  #include <linux/clk-provider.h>
>>>>>> +#include <linux/gpio/consumer.h>
>>>>>>  #include <linux/mfd/syscon.h>
>>>>>>  #include <linux/module.h>
>>>>>>  #include <linux/of_device.h>
>>>>>> @@ -23,6 +24,7 @@
>>>>>>  #include <linux/regmap.h>
>>>>>>  #include <linux/of.h>
>>>>>>  #include <linux/firmware/xlnx-zynqmp.h>
>>>>>> +#include <linux/firmware/intel/keembay_firmware.h>
>>>>>>
>>>>>>  #include "cqhci.h"
>>>>>>  #include "sdhci-pltfm.h"
>>>>>> @@ -136,6 +138,7 @@ struct sdhci_arasan_clk_data {
>>>>>>   * @soc_ctl_base:      Pointer to regmap for syscon for soc_ctl registers.
>>>>>>   * @soc_ctl_map:       Map to get offsets into soc_ctl registers.
>>>>>>   * @quirks:            Arasan deviations from spec.
>>>>>> + * @uhs_gpio:          Pointer to the uhs gpio.
>>>>>>   */
>>>>>>  struct sdhci_arasan_data {
>>>>>>         struct sdhci_host *host;
>>>>>> @@ -150,6 +153,7 @@ struct sdhci_arasan_data {
>>>>>>         struct regmap   *soc_ctl_base;
>>>>>>         const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
>>>>>>         unsigned int    quirks;
>>>>>> +       struct gpio_desc *uhs_gpio;
>>>>>>
>>>>>>  /* Controller does not have CD wired and will not function
>>>>>> normally without
>>>>> */
>>>>>>  #define SDHCI_ARASAN_QUIRK_FORCE_CDTEST        BIT(0)
>>>>>> @@ -361,6 +365,112 @@ static int sdhci_arasan_voltage_switch(struct
>>>>> mmc_host *mmc,
>>>>>>         return -EINVAL;
>>>>>>  }
>>>>>>
>>>>>> +static int sdhci_arasan_keembay_voltage_switch(struct mmc_host
>>> *mmc,
>>>>>> +                                      struct mmc_ios *ios) {
>>>>>> +       struct sdhci_host *host = mmc_priv(mmc);
>>>>>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>>>> +       struct sdhci_arasan_data *sdhci_arasan =
>>> sdhci_pltfm_priv(pltfm_host);
>>>>>> +       u16 ctrl_2, clk;
>>>>>> +       int ret;
>>>>>> +
>>>>>> +       switch (ios->signal_voltage) {
>>>>>> +       case MMC_SIGNAL_VOLTAGE_180:
>>>>>> +               clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>>>>>> +               clk &= ~SDHCI_CLOCK_CARD_EN;
>>>>>> +               sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>>>>>> +
>>>>>> +               clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>>>>>> +               if (clk & SDHCI_CLOCK_CARD_EN)
>>>>>> +                       return -EAGAIN;
>>>>>> +
>>>>>> +               sdhci_writeb(host, SDHCI_POWER_ON | SDHCI_POWER_180,
>>>>>> +                                  SDHCI_POWER_CONTROL);
>>>>>> +
>>>>>> +               /*
>>>>>> +                * Set VDDIO_B voltage to Low for 1.8V
>>>>>> +                * which is controlling by GPIO Expander.
>>>>>> +                */
>>>>>> +               gpiod_set_value_cansleep(sdhci_arasan->uhs_gpio,
>>>>>> + 0);
>>>>>> +
>>>>>> +               /*
>>>>>> +                * This is like a final gatekeeper. Need to ensure changed
>>> voltage
>>>>>> +                * is settled before and after turn on this bit.
>>>>>> +                */
>>>>>> +               usleep_range(1000, 1100);
>>>>>> +
>>>>>> +               ret =
>>> keembay_sd_voltage_selection(KEEMBAY_SET_1V8_VOLT);
>>>>>> +               if (ret)
>>>>>> +                       return ret;
>>>>>> +
>>>>>> +               usleep_range(1000, 1100);
>>>>>
>>>>> No, sorry, but I don't like this.
>>>>>
>>>>> This looks like a GPIO regulator with an extension of using the
>>>>> keembay_sd_voltage_selection() thingy. I think you can model these
>>>>> things behind a regulator and hook it up as a vqmmc supply in DT
>>>>> instead. BTW, this is the common way we deal with these things for mmc
>>> host drivers.
>>>>
>>>> The SDcard for Keem Bay SOC does not have its own voltage regulator.
>>>> There are 2 places to control the voltage.
>>>> 1) By setting the AON register calling system-level platform management
>>> layer (SMC)
>>>>    to set the I/O pads voltage for particular GPIOs line for clk,data and cmd.
>>>>    The reason why I use this keembay_sd_voltage_selection() via smccc
>>> interface it because during voltage switching
>>>>    I need to access to AON register. On a secure system, we could not
>>> directly access to AON register due to some security concern from driver side,
>>> thus
>>>>    cannot exposed any register or address.
>>>> 2) By controlling the GPIO expander value to drive either 1.8V or 3.3V for
>>> power mux input.
>>>
>>> I see, thanks for clarifying.
>>>
>>> To me, it sounds like the best fit is to implement a pinctrl (to manage the I/O
>>> pads) and a GPIO regulator.
>>>
>> Even with pinctrl, i still need to use the keembay_sd_voltage_selection() thingy for AON register.
> 
> Yes, I am fine by that.
> 
> Although, as it's really a pinctrl, it deserves to be modelled like
> that. Not as a soc specific hack in a mmc host driver.

:-)

> 
>> Plus, the GPIO pin that control the sd-voltage is in GPIO Expander not using Keembay SOC GPIO Pin.
>> The best option is using the gpio consumer function to toggle the pin.
> 
> As I said, please no.
> 
> The common way to model this is as a GPIO regulator. In this way, you
> can even rely on existing mmc DT bindings. All you have to do is to
> hook up a vqmmc supply to the mmc node.

regulators were mentioned here in v1
https://lore.kernel.org/linux-arm-kernel/21d34b75-5947-e115-7c9a-6d068375bbdd@xilinx.com/

> 
> To be clear, as long as there are no arguments for why a pinctrl and
> GPIO regulator can't be used - I am not going to pick up the patches.

I mentioned pinctrl here also in v1 thread.
http://lore.kernel.org/r/6b1c9c71-ca10-47b0-895c-adafc6881063@xilinx.com

Thanks,
Michal
