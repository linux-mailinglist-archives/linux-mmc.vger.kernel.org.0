Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17707462E3A
	for <lists+linux-mmc@lfdr.de>; Tue, 30 Nov 2021 09:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbhK3IKX (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 30 Nov 2021 03:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239502AbhK3IKX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Nov 2021 03:10:23 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC19C061574
        for <linux-mmc@vger.kernel.org>; Tue, 30 Nov 2021 00:07:04 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id d10so50189435ybe.3
        for <linux-mmc@vger.kernel.org>; Tue, 30 Nov 2021 00:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qSij28nB3wBelLtuDui1SptkhddE/h2anUQuiZCNXUw=;
        b=USd0Sa5S5wlj11L+ZNOLrDZe9FLvUSoaMbNVBXkTvPi2iCJyt1kYqbPI4ke4ETmMzG
         dy+y5j1UrO3XKa2hurDJR7is3jDpUWrvRrP+NUAtGpCUTXw2++GhVgsGy+qXg3/lXO1S
         acDi7dvk7gIuP8Cb2NzZ0ybDgdX68KR+aZp52n5GmyoMQJX7MJwG5YOxmGJjIFLexHoi
         +6i2zIn5ZotC14yeotNgRlm1CYyhqopWbODDGg5mJdl5Bw43dEYJeFpNPbYnDb9rx/yK
         eBWBawgu1yCgYPG+i77Kacbdwt3ZxKqLzlMO/Vm37+slC7sn9KrStObDLqyPLgh2oXPW
         aEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSij28nB3wBelLtuDui1SptkhddE/h2anUQuiZCNXUw=;
        b=dD/2GgjnveSTItK7WrIscl8o5yJBDuwRkQpW4susrd1ClJ2MPqW5QsGdaTTgSdDlh8
         OwUQUKYW40T5C5WEvojlxOE5N7LVHDZb4bM1SV/q3rmyiRWUciCB0uvgw3pLmzScIqaF
         KW3ZOAKlcpCBKxkLpuaHxfJrVXor93m45nRp1l5ioLKp4zF9QxYo0Wt3hdYSXHs6jROt
         yjuBuZ0e/hBafwPc+zFlRamww7MCtJurp4FeLPIadmgTtPF3mmclBBRbN1HDnZOCboAU
         B9i1VEF4+MQ7SYEy/48UNhonRdgWK+6Weu2iQ3vhd2B3zevnDPyDtPXKfxLlhgiZaS0w
         s2lg==
X-Gm-Message-State: AOAM5308YQZcv6wkNJAFpMKVuMjZkxnGfJ1L8IPBmpJ3pn26EimNfJBH
        QclEmVPAdlRPWArQQqgXFaYBx91zk8sT1decEjGRD3/Es3k=
X-Google-Smtp-Source: ABdhPJw3yFxmmEuIazqzW3gY1ViDJM6Zto3ikgouZAcNgbRvNlGR5FoJ5aypyFzJpen62I5AlTAKWAfL6IqPvDtO8g0=
X-Received: by 2002:a25:d17:: with SMTP id 23mr12075203ybn.652.1638259623355;
 Tue, 30 Nov 2021 00:07:03 -0800 (PST)
MIME-Version: 1.0
References: <20210831110227.50780-1-jasonlai.genesyslogic@gmail.com> <CAPDyKFpqCtj03YZEU=m8yJ6KPWgYub5O_icqg29FnsppvbhKYg@mail.gmail.com>
In-Reply-To: <CAPDyKFpqCtj03YZEU=m8yJ6KPWgYub5O_icqg29FnsppvbhKYg@mail.gmail.com>
From:   Lai Jason <jasonlai.genesyslogic@gmail.com>
Date:   Tue, 30 Nov 2021 16:06:52 +0800
Message-ID: <CAG0XXUEibYuKcO0-yKY0wZcPmjreFz-XzZZNszk3VA6iMAp+yQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] mmc: core: Implement content of UHS-II card
 initialization functions
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Takahiro Akashi <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jason Lai <jason.lai@genesyslogic.com.tw>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        =?UTF-8?B?R3JlZ1R1W+adnOWVn+i7kl0=?= <greg.tu@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,
 Next version of UHS-II patch is going to be submitted.
Most of your comments are applied except 2 items.
Please see details below.

On Thu, Sep 9, 2021 at 10:29 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 31 Aug 2021 at 13:02, Jason Lai <jasonlai.genesyslogic@gmail.com> wrote:
> >
> > From: Jason Lai <jason.lai@genesyslogic.com.tw>
> >
> > From: Jason Lai <jason.lai@genesyslogic.com.tw>
> >
> > UHS-II card initialization flow is divided into 2 categories: PHY & Card.
> > Part 1 - PHY Initialization:
> >          Every host controller may need their own avtivation operation
> >          to establish LINK between controller and card. So we add a new
> >          member function(uhs2_detect_init) in struct mmc_host_ops for host
> >          controller use.
> > Part 2 - Card Initialization:
> >          This part can be divided into 6 substeps.
> >          1. Send UHS-II CCMD DEVICE_INIT to card.
> >          2. Send UHS-II CCMD ENUMERATE to card.
> >          3. Send UHS-II Native Read CCMD to obtain capabilities in CFG_REG
> >             of card.
> >          4. Host compares capabilities of host controller and  card,
> >             then write the negotiated values to Setting field in CFG_REG
> >             of card through UHS-II Native Write CCMD.
> >          5. Switch host controller's clock to Range B if it is supported
> >             by both host controller and card.
> >          6. Execute legacy SD initialization flow.
> >
> > Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/core/sd_uhs2.c | 918 +++++++++++++++++++++++++++++++++++--
> >  1 file changed, 868 insertions(+), 50 deletions(-)
> >
> > diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> > index 24aa51a6d..d9ceee20d 100644
> > --- a/drivers/mmc/core/sd_uhs2.c
> > +++ b/drivers/mmc/core/sd_uhs2.c
> > @@ -3,6 +3,7 @@
> >   * Copyright (C) 2021 Linaro Ltd
> >   *
> >   * Author: Ulf Hansson <ulf.hansson@linaro.org>
> > + * Author: Jason Lai <jason.lai@genesyslogic.com.tw>
> >   *
> >   * Support for SD UHS-II cards
> >   */
> > @@ -10,29 +11,37 @@
> >
> >  #include <linux/mmc/host.h>
> >  #include <linux/mmc/card.h>
> > +#include <linux/mmc/sd_uhs2.h>
> >
> >  #include "core.h"
> >  #include "bus.h"
> >  #include "sd.h"
> >  #include "mmc_ops.h"
> > +#include "sd_uhs2.h"
> >
> >  static const unsigned int sd_uhs2_freqs[] = { 52000000, 26000000 };
> >
> > -static int sd_uhs2_set_ios(struct mmc_host *host)
> > +static void sd_uhs2_set_ios(struct mmc_host *host)
> >  {
> >         struct mmc_ios *ios = &host->ios;
> >
> > -       return host->ops->uhs2_set_ios(host, ios);
> > +       pr_debug("%s: clock=%uHz, bus_mode=%u, power_mode=%u, ",
> > +                mmc_hostname(host), ios->clock, ios->bus_mode,
> > +                ios->power_mode);
> > +       pr_debug("cs=%u, Vdd=%u, width=%u, timing=%u\n",
> > +                ios->chip_select, ios->vdd, 1 << ios->bus_width,
> > +                ios->timing);
>
> I see that you are enjoying a lot of debug code. I guess those have
> been useful during development, but please - we don't need all of
> these. Try to be a little more selective and keep only a small subset
> of them. This applies to the whole series, of course.
>
> > +
> > +       host->ops->uhs2_set_ios(host, ios);
>
> I would expect that this host ops can fail. Therefore, please don't
> convert functions to void, unless there are really good reasons to.
>

There is only one action inside uhs2_set_ios(host, ios) :
host->ops->set_ios(host, ios);
In this case, the real function be called is:
    void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios) in
./drivers/mmc/host/sdhci.c
That's why uhs2_set_ios(host, ios) returned VOID.

> >  }
> >
> > -static int sd_uhs2_power_up(struct mmc_host *host)
> > +static void sd_uhs2_power_up(struct mmc_host *host)
> >  {
> >         host->ios.vdd = fls(host->ocr_avail) - 1;
> >         host->ios.clock = host->f_init;
> >         host->ios.timing = MMC_TIMING_SD_UHS2;
> >         host->ios.power_mode = MMC_POWER_UP;
> >
> > -       return sd_uhs2_set_ios(host);
> > +       sd_uhs2_set_ios(host);
>
> Ditto.

The same as above.

> >  }
> >
> >  static void sd_uhs2_power_off(struct mmc_host *host)
> > @@ -45,6 +54,43 @@ static void sd_uhs2_power_off(struct mmc_host *host)
> >         sd_uhs2_set_ios(host);
> >  }
> >
> > +/*
> > + * uhs2_cmd_assemble - assemble and build up uhs2 command
> > + * @cmd:       MMC command
> > + * @uhs2_cmd:  UHS2 command
> > + * @header:    Value of packet header
> > + * @arg:       Argument of packet
> > + * @payload:   Payload of packet
> > + * @plen:      Payload length
> > + * @resp:      Buffer for response
> > + * @resp_len:  Response buffer length
> > + *
> > + * resp is inputted outside which should be a variable created by caller
> > + * so caller should handle it. For SD command, there is no uhs2_resp and
> > + * response should be stored in resp of mmc_command.
>
> Please, try to rephrase this section. It's really hard to understand
> what is expected from the caller here.
>
> Additionally, it's good practice to describe what the function really
> does. Please add that as well.
>
> > + */
> > +static void uhs2_cmd_assemble(struct mmc_command *cmd,
> > +                             struct uhs2_command *uhs2_cmd,
> > +                             u16 header, u16 arg,
> > +                             u32 *payload, u8 plen, u8 *resp, u8 resp_len)
> > +{
> > +       uhs2_cmd->header = header;
> > +       uhs2_cmd->arg = arg;
> > +       uhs2_cmd->payload = payload;
> > +       uhs2_cmd->payload_len = plen * sizeof(u32);
> > +       uhs2_cmd->packet_len = uhs2_cmd->payload_len + 4;
> > +
> > +       cmd->uhs2_cmd = uhs2_cmd;
> > +       cmd->uhs2_resp = resp;
> > +       cmd->uhs2_resp_len = resp_len;
> > +
> > +       pr_debug("%s: uhs2_cmd: header=0x%x arg=0x%x\n",
> > +                __func__, uhs2_cmd->header, uhs2_cmd->arg);
> > +       pr_debug("%s:           payload_len=%d packet_len=%d resp_len=%d\n",
> > +                __func__, uhs2_cmd->payload_len, uhs2_cmd->packet_len,
> > +                cmd->uhs2_resp_len);
>
> Debug again. I will stop commenting on this from now on, you get the point.
>
> > +}
> > +
> >  /*
> >   * Run the phy initialization sequence, which mainly relies on the UHS-II host
> >   * to check that we reach the expected electrical state, between the host and
> > @@ -52,16 +98,104 @@ static void sd_uhs2_power_off(struct mmc_host *host)
> >   */
> >  static int sd_uhs2_phy_init(struct mmc_host *host)
> >  {
> > +       int err = 0;
> > +
> > +       /*
> > +        * Every host controller can assign its own function which is used
> > +        * to initialize PHY.
> > +        */
> > +       if (host->ops->uhs2_detect_init) {
>
> You certainly need to add a few host ops, but I wonder if this one
> should be optional?
>
> > +               err = host->ops->uhs2_detect_init(host)
> > +               if (err) {
> > +                       pr_err("%s: fail to detect UHS2!\n",
> > +                              mmc_hostname(host));
> > +                       err = UHS2_PHY_INIT_ERR;
>
> Please don't use UHS-II specific error codes in this way. If possible,
> please stick with standard error codes that get returned from the
> ->uhs2_detect_init() ops.
>
> > +               }
> > +       }
> > +
>
> So, you return 0 below and just ignore the error code from
> host->ops->uhs2_detect_init(). That looks weird.
>
> >         return 0;
> >  }
> >
> >  /*
> >   * Do the early initialization of the card, by sending the device init
> > -roadcast
> > - * command and wait for the process to be completed.
> > + * broadcast command and wait for the process to be completed.
>
> If there is a spelling error or some other things that looks wrong in
> my original patch(es), please fix those instead (and add your
> signed-off-by tag), rather than doing it on top as here.
>
> >   */
> >  static int sd_uhs2_dev_init(struct mmc_host *host)
> >  {
> > +       struct mmc_command cmd = {0};
> > +       struct uhs2_command uhs2_cmd = {};
> > +       u32 cnt;
> > +       u32 dap, gap, gap1;
> > +       u16 header = 0, arg = 0;
> > +       u32 payload[1];
> > +       u8 plen = 1;
> > +       u8 gd = 0, cf = 1;
>
> It's good practice to use self-explanatory names of variables, simply
> because it helps to understand the code. Would you mind improving some
> of the variable names above?
>

The variable naming is the same as described in UHS-II Addendum specification.
Using the same name will make it easier to find them in specification.

> > +       u8 resp[6] = {0};
> > +       u8 resp_len = 6;
> > +       int err;
> > +
> > +       dap = host->uhs2_caps.dap;
> > +       gap = host->uhs2_caps.gap;
> > +
> > +       header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD;
> > +       arg = ((UHS2_DEV_CMD_DEVICE_INIT & 0xFF) << 8) |
> > +               UHS2_NATIVE_CMD_WRITE |
> > +               UHS2_NATIVE_CMD_PLEN_4B |
> > +               (UHS2_DEV_CMD_DEVICE_INIT >> 8);
> > +
> > +       /* need this for some cards */
> > +       cmd.busy_timeout = 1000;
>
> If you could refer to the SD spec about what timeout that should be
> used that would be great.
>
> Moreover, if nothing is specified about this, then state that too, so
> we know what goes on here.
>
> > +
> > +       for (cnt = 0; cnt < 30; cnt++) {
>
> Why loop for 30 times? Is there something that you can refer to in the
> SD spec about this - or it's just empirically tested?
>
> > +               payload[0] = ((dap & 0xF) << 12) |
> > +                       (cf << 11)         |
> > +                       ((gd & 0xF) << 4)  |
> > +                       (gap & 0xF);
> > +
>
> It would be nice to understand (just put a comment here somewhere) of
> what kind of payload you build here. Perhaps better variable names
> would help, as stated above.
>
> > +               uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg,
>
> Please use sd_uhs2* as prefix for all functions related to UHS-II.
> Consistency makes it easier to review and maintain code.
>
> > +                                 payload, plen, resp, resp_len);
> > +
> > +               DBG("Begin DEVICE_INIT, header=0x%x, arg=0x%x, payload=0x%x.\n",
> > +                   header, arg, payload[0]);
> > +
> > +               DBG("Sending DEVICE_INIT. Count = %d\n", cnt);
> > +               err = mmc_wait_for_cmd(host, &cmd, 0);
> > +
> > +               if (err) {
> > +                       pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> > +                              mmc_hostname(host), __func__, err);
> > +                       return -EIO;
> > +               }
> > +
> > +               if (IS_ENABLED(CONFIG_MMC_DEBUG)) {
>
> Please drop this. Use pr_debug or dev_dbg, that should be sufficient.
>
> > +                       int i;
> > +
> > +                       pr_warn("%s: DEVICE_INIT response is: ",
> > +                               mmc_hostname(host));
> > +                       for (i = 0; i < resp_len; i++)
> > +                               pr_warn("0x%x ", resp[i]);
> > +                       pr_warn("\n");
> > +               }
> > +
> > +               if (resp[3] != (UHS2_DEV_CMD_DEVICE_INIT & 0xFF)) {
> > +                       pr_err("%s: DEVICE_INIT response is wrong!\n",
> > +                              mmc_hostname(host));
> > +                       return -EIO;
> > +               }
> > +
> > +               if (resp[5] & 0x8) {
> > +                       DBG("CF is set, device is initialized!\n");
> > +                       host->group_desc = gd;
> > +                       break;
> > +               }
> > +               gap1 = resp[4] & 0x0F;
> > +               if (gap == gap1)
> > +                       gd++;
> > +       }
> > +       if (cnt == 30) {
>
> Looks like a do-while loop may be better suited above, so this can be
> skipped. Please give it a try and see if that improves the code a bit.
>
> > +               pr_err("%s: DEVICE_INIT fail, already 30 times!\n",
> > +                      mmc_hostname(host));
> > +               return -EIO;
> > +       }
> > +
> >         return 0;
> >  }
> >
> > @@ -70,8 +204,60 @@ static int sd_uhs2_dev_init(struct mmc_host *host)
> >   * Note that, we currently support only the point to point connection, which
> >   * means only one card can be attached per host/slot.
> >   */
> > -static int sd_uhs2_enum(struct mmc_host *host, u32 *node_id)
> > +static int sd_uhs2_enum(struct mmc_host *host)
>
> I am not sure why I added the node_id, probably for a good reason.
> Anyway, if you think it isn't needed please update the original
> patch2.
>
> >  {
> > +       struct mmc_command cmd = {0};
> > +       struct uhs2_command uhs2_cmd = {};
> > +       u16 header = 0, arg = 0;
> > +       u32 payload[1];
> > +       u8 plen = 1;
> > +       u8 id_f = 0xF, id_l = 0x0;
>
> Again, please improve variable names. I am stopping from commenting on
> this again, it applies to the whole series.
>
> > +       u8 resp[8] = {0};
> > +       u8 resp_len = 8;
> > +       int err;
> > +
> > +       header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD;
> > +       arg = ((UHS2_DEV_CMD_ENUMERATE & 0xFF) << 8) |
> > +               UHS2_NATIVE_CMD_WRITE |
> > +               UHS2_NATIVE_CMD_PLEN_4B |
> > +               (UHS2_DEV_CMD_ENUMERATE >> 8);
> > +
> > +       payload[0] = (id_f << 4) | id_l;
> > +
> > +       DBG("Begin ENUMERATE, header=0x%x, arg=0x%x, payload=0x%x.\n",
> > +           header, arg, payload[0]);
> > +       uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, plen,
> > +                         resp, resp_len);
> > +
> > +       err = mmc_wait_for_cmd(host, &cmd, 0);
> > +       if (err) {
> > +               pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> > +                      mmc_hostname(host), __func__, err);
> > +               return -EIO;
> > +       }
> > +
> > +       if (IS_ENABLED(CONFIG_MMC_DEBUG)) {
> > +               int i;
> > +
> > +               pr_warn("%s: ENUMERATE response is: ", mmc_hostname(host));
> > +               for (i = 0; i < resp_len; i++)
> > +                       pr_warn("0x%x ", resp[i]);
> > +               pr_warn("\n");
> > +       }
> > +
> > +       if (resp[3] != (UHS2_DEV_CMD_ENUMERATE & 0xFF)) {
> > +               pr_err("%s: ENUMERATE response is wrong!\n",
> > +                      mmc_hostname(host));
> > +               return -EIO;
> > +       }
> > +
> > +       id_f = (resp[4] >> 4) & 0xF;
> > +       id_l = resp[4] & 0xF;
> > +       DBG("id_f = %d, id_l = %d.\n", id_f, id_l);
> > +       DBG("Enumerate Cmd Completed. No. of Devices connected = %d\n",
> > +           id_l - id_f + 1);
> > +       host->uhs2_dev_prop.node_id = id_f;
> > +
> >         return 0;
> >  }
> >
> > @@ -80,8 +266,158 @@ static int sd_uhs2_enum(struct mmc_host *host, u32 *node_id)
> >   * commands and by parsing the responses. Store a copy of the relevant data in
> >   * card->uhs2_config.
> >   */
> > -static int sd_uhs2_config_read(struct mmc_host *host, struct mmc_card *card)
> > +static int sd_uhs2_config_read(struct mmc_host *host)
>
> The idea with passing the *card as an in-parameter is to allow it to
> fill uhs2 cap/config. I guess that becomes obvious, when you look at
> my comment for patch5.
>
> Card specific data belongs in the struct mmc_card, not in the mmc_host.
>
> >  {
> > +       struct mmc_command cmd = {0};
> > +       struct uhs2_command uhs2_cmd = {};
> > +       u16 header = 0, arg = 0;
> > +       u32 cap;
> > +       int err;
> > +
> > +       DBG("INQUIRY_CFG: read Generic Caps.\n");
> > +       header = UHS2_NATIVE_PACKET |
> > +                UHS2_PACKET_TYPE_CCMD |
> > +                host->uhs2_dev_prop.node_id;
> > +       arg = ((UHS2_DEV_CONFIG_GEN_CAPS & 0xFF) << 8) |
> > +               UHS2_NATIVE_CMD_READ |
> > +               UHS2_NATIVE_CMD_PLEN_4B |
> > +               (UHS2_DEV_CONFIG_GEN_CAPS >> 8);
> > +
> > +       pr_debug("Begin INQUIRY_CFG, header=0x%x, arg=0x%x.\n", header, arg);
> > +       /* There is no payload because per spec, there should be
> > +        * no payload field for read CCMD.
> > +        * Plen is set in arg. Per spec, plen for read CCMD
> > +        * represents the len of read data which is assigned in payload
> > +        * of following RES (p136).
> > +        */
> > +       uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL, 0);
> > +
> > +       err = mmc_wait_for_cmd(host, &cmd, 0);
> > +       if (err) {
> > +               pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> > +                      mmc_hostname(host), __func__, err);
> > +               return -EIO;
>
> There is no reason to override the error code from mmc_wait_for_cmd().
> Please just use that instead. That applies to many other places below
> and above as well. Please fix them all.
>
> > +       }
> > +
> > +       if (IS_ENABLED(CONFIG_MMC_DEBUG)) {
> > +               int i;
> > +
> > +               pr_warn("%s: INQUIRY_CFG generic response is: ",
> > +                       mmc_hostname(host));
> > +               for (i = 0; i < 2; i++)
> > +                       pr_warn("0x%x ", cmd.resp[i]);
> > +               pr_warn("\n");
> > +       }
> > +
> > +       cap = cmd.resp[0];
> > +       pr_debug("Device Generic Caps (0-31) is: 0x%x.\n", cap);
> > +       host->uhs2_dev_prop.n_lanes = (cap >> UHS2_DEV_CONFIG_N_LANES_POS) &
> > +                                       UHS2_DEV_CONFIG_N_LANES_MASK;
> > +       host->uhs2_dev_prop.dadr_len = (cap >> UHS2_DEV_CONFIG_DADR_POS) &
> > +                                       UHS2_DEV_CONFIG_DADR_MASK;
> > +       host->uhs2_dev_prop.app_type = (cap >> UHS2_DEV_CONFIG_APP_POS) &
> > +                                       UHS2_DEV_CONFIG_APP_MASK;
> > +
> > +       pr_debug("INQUIRY_CFG: read PHY Caps.\n");
> > +       arg = ((UHS2_DEV_CONFIG_PHY_CAPS & 0xFF) << 8) |
> > +               UHS2_NATIVE_CMD_READ |
> > +               UHS2_NATIVE_CMD_PLEN_8B |
> > +               (UHS2_DEV_CONFIG_PHY_CAPS >> 8);
> > +
> > +       pr_debug("Begin INQUIRY_CFG, header=0x%x, arg=0x%x.\n", header, arg);
> > +       uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL, 0);
> > +
> > +       err = mmc_wait_for_cmd(host, &cmd, 0);
> > +       if (err) {
> > +               pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> > +                      mmc_hostname(host), __func__, err);
> > +               return -EIO;
> > +       }
> > +
> > +       if (IS_ENABLED(CONFIG_MMC_DEBUG)) {
> > +               int i;
> > +
> > +               pr_warn("%s: INQUIRY_CFG PHY response is: ",
> > +                       mmc_hostname(host));
> > +               for (i = 0; i < 2; i++)
> > +                       pr_warn("0x%x ", cmd.resp[i]);
> > +               pr_warn("\n");
> > +       }
> > +
> > +       cap = cmd.resp[0];
> > +       pr_debug("Device PHY Caps (0-31) is: 0x%x.\n", cap);
> > +       host->uhs2_dev_prop.phy_minor_rev = cap &
> > +                                       UHS2_DEV_CONFIG_PHY_MINOR_MASK;
> > +       host->uhs2_dev_prop.phy_major_rev = (cap >>
> > +                                       UHS2_DEV_CONFIG_PHY_MAJOR_POS) &
> > +                                       UHS2_DEV_CONFIG_PHY_MAJOR_MASK;
> > +       host->uhs2_dev_prop.can_hibernate = (cap >>
> > +                                       UHS2_DEV_CONFIG_CAN_HIBER_POS) &
> > +                                       UHS2_DEV_CONFIG_CAN_HIBER_MASK;
> > +
> > +       cap = cmd.resp[1];
> > +       pr_debug("Device PHY Caps (32-63) is: 0x%x.\n", cap);
> > +       host->uhs2_dev_prop.n_lss_sync = cap & UHS2_DEV_CONFIG_N_LSS_SYN_MASK;
> > +       host->uhs2_dev_prop.n_lss_dir = (cap >>
> > +                                       UHS2_DEV_CONFIG_N_LSS_DIR_POS) &
> > +                                       UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
> > +       if (host->uhs2_dev_prop.n_lss_sync == 0)
> > +               host->uhs2_dev_prop.n_lss_sync = 16 << 2;
> > +       else
> > +               host->uhs2_dev_prop.n_lss_sync <<= 2;
> > +
> > +       if (host->uhs2_dev_prop.n_lss_dir == 0)
> > +               host->uhs2_dev_prop.n_lss_dir = 16 << 3;
> > +       else
> > +               host->uhs2_dev_prop.n_lss_dir <<= 3;
> > +
> > +       pr_debug("INQUIRY_CFG: read LINK-TRAN Caps.\n");
> > +       arg = ((UHS2_DEV_CONFIG_LINK_TRAN_CAPS & 0xFF) << 8) |
> > +               UHS2_NATIVE_CMD_READ |
> > +               UHS2_NATIVE_CMD_PLEN_8B |
> > +               (UHS2_DEV_CONFIG_LINK_TRAN_CAPS >> 8);
> > +
> > +       pr_debug("Begin INQUIRY_CFG, header=0x%x, arg=0x%x.\n", header, arg);
> > +       uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL, 0);
> > +
> > +       err = mmc_wait_for_cmd(host, &cmd, 0);
> > +       if (err) {
> > +               pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> > +                      mmc_hostname(host), __func__, err);
> > +               return -EIO;
> > +       }
> > +
> > +       if (IS_ENABLED(CONFIG_MMC_DEBUG)) {
> > +               int i;
> > +
> > +               pr_warn("%s: INQUIRY_CFG Link-Tran response is: ",
> > +                       mmc_hostname(host));
> > +               for (i = 0; i < 2; i++)
> > +                       pr_warn("0x%x ", cmd.resp[i]);
> > +               pr_warn("\n");
> > +       }
> > +
> > +       cap = cmd.resp[0];
> > +       DBG("Device LINK-TRAN Caps (0-31) is: 0x%x.\n", cap);
> > +       host->uhs2_dev_prop.link_minor_rev = cap &
> > +                                       UHS2_DEV_CONFIG_LT_MINOR_MASK;
> > +       host->uhs2_dev_prop.link_major_rev = (cap >>
> > +                                       UHS2_DEV_CONFIG_LT_MAJOR_POS) &
> > +                                       UHS2_DEV_CONFIG_LT_MAJOR_MASK;
> > +       host->uhs2_dev_prop.n_fcu = (cap >> UHS2_DEV_CONFIG_N_FCU_POS) &
> > +                                       UHS2_DEV_CONFIG_N_FCU_MASK;
> > +       host->uhs2_dev_prop.dev_type = (cap >> UHS2_DEV_CONFIG_DEV_TYPE_POS) &
> > +                                       UHS2_DEV_CONFIG_DEV_TYPE_MASK;
> > +       host->uhs2_dev_prop.maxblk_len = (cap >>
> > +                                       UHS2_DEV_CONFIG_MAX_BLK_LEN_POS) &
> > +                                       UHS2_DEV_CONFIG_MAX_BLK_LEN_MASK;
> > +
> > +       cap = cmd.resp[1];
> > +       DBG("Device LINK-TRAN Caps (32-63) is: 0x%x.\n", cap);
> > +       host->uhs2_dev_prop.n_data_gap = cap & UHS2_DEV_CONFIG_N_DATA_GAP_MASK;
> > +       if (host->uhs2_dev_prop.n_fcu == 0)
> > +               host->uhs2_dev_prop.n_fcu = 256;
> > +
> >         return 0;
> >  }
> >
> > @@ -89,15 +425,393 @@ static int sd_uhs2_config_read(struct mmc_host *host, struct mmc_card *card)
> >   * Based on the card's and host's UHS-II capabilities, let's update the
> >   * configuration of the card and the host. This may also include to move to a
> >   * greater speed range/mode. Depending on the updated configuration, we may
> > -eed
> > - * to do a soft reset of the card via sending it a GO_DORMANT_STATE command.
> > + * need to do a soft reset of the card via sending it a GO_DORMANT_STATE command.
> >   *
> > - * In the final step, let's check if the card signals "config completion",
> > -hich
> > - * indicates that the card has moved from config state into active state.
> > + * In the final step, let's check if the card signals "config completion",
> > + * which indicates that the card has moved from config state into active state.
> >   */
> > -static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
> > +static int sd_uhs2_config_write(struct mmc_host *host)
>
> Again, the struct mmc_card is passed here for a reason. It should
> contain the config/caps for the card.
>
> I think I will just stop reviewing here - as it looks like you have
> quite some cleanups to fix at this point.
>
> I am looking forward to reviewing your next version.
>
> [...]
>
> Kind regards
> Uffe
