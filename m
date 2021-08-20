Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8523F31E4
	for <lists+linux-mmc@lfdr.de>; Fri, 20 Aug 2021 19:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbhHTRCW (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 20 Aug 2021 13:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbhHTRCS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Aug 2021 13:02:18 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED06FC0612A3
        for <linux-mmc@vger.kernel.org>; Fri, 20 Aug 2021 10:01:37 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so6754598otg.11
        for <linux-mmc@vger.kernel.org>; Fri, 20 Aug 2021 10:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7+Objv6i9DmTC/GMLfVRuDD2b04IsyqfYBCngR4TqEA=;
        b=VUVTkfJxilVSNSnmnsmdM9ydLw6cLOLjiV9O1h84iDwGGKeleSGq/z0n88M9BarB34
         zuHJZQ+Un7etTx/B98zFvsG0xZVvmMQ/q757BM4HwGqsNf0t3WAkPVDQHZUSR0zYxOOk
         3I8YoZJ6a6DWXp9r4StejHqeoL/z3O1CtHFQl77FZN2018FiWfqcoe0Pya8T43DEo0U2
         bQDBi4JNlWWbUTvMwQeLnyZD267VxMFxiAjHwynrCcB/tTVwYz3LilLD7cTC98MbZuNR
         ThTIy9p9CBDf5jvjTVyrWC7TZKjIUCorvF4o/ecR3s7qu3aqhdAmbSjGeFUHmaVu3s2b
         ho7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7+Objv6i9DmTC/GMLfVRuDD2b04IsyqfYBCngR4TqEA=;
        b=gDAaN391Jz+8I9KxRjSBis9B5eYeEUmfsZtWwbTAbr/9GqlFr0hJWPe6SHlUOCJbot
         PL++fvC32fcZw7P02UyUUZFr3ZLxE+8gljlfGgWfxijzfVhLZyAPxtR4k1A00Zf44Oxe
         oaArrXOMwLWwL/Ge3vNN5G5JD1msYzVJIUHLK4d91x1ppa0RYYGjv88Brc2FrXnHXPi1
         aEfZuNQ2sQ5D3GYXcC5wuTVd+EAOoZt4/M91cPQ0xUdC3DJTViA9dJhtrzjWJaKcH1lT
         VVNP137mMHsx1p8YZlg9HyZmZFHJXgwQpVp9S8Msf4HbcB1NP3zfepioN7MASMbsDmZz
         U69A==
X-Gm-Message-State: AOAM531xI+/IP00rl1fE7PdPIDhOdQkDwj25H5di9EhWnEzyIBuaGgW9
        yC95XOEXsVLAnnhkdNRvcpHloA==
X-Google-Smtp-Source: ABdhPJwh3RFgheApQFS1RlK2kyFKcJkU8VRb38Zvs3CD2Q+PFpUlJngtjnhNYlepCxDAJjc3/+kyZw==
X-Received: by 2002:a9d:27a4:: with SMTP id c33mr17974382otb.281.1629478897320;
        Fri, 20 Aug 2021 10:01:37 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n73sm1564722oig.9.2021.08.20.10.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 10:01:36 -0700 (PDT)
Date:   Fri, 20 Aug 2021 10:02:59 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Andy Gross <agross@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        MSM <linux-arm-msm@vger.kernel.org>, linux-mmc@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [RFC PATCH 00/15] create power sequencing subsystem
Message-ID: <YR/gQ0K9MjddBVwY@ripper>
References: <20210817005507.1507580-1-dmitry.baryshkov@linaro.org>
 <1CA665D1-86F0-45A1-862D-17DAB3ABA974@holtmann.org>
 <CAA8EJpoOxerwmwQozL3gp1nX-+oxLMFUFjVPvRy-MoVfPuvqrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpoOxerwmwQozL3gp1nX-+oxLMFUFjVPvRy-MoVfPuvqrw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri 20 Aug 06:08 PDT 2021, Dmitry Baryshkov wrote:

> Hi,
> 
> On Thu, 19 Aug 2021 at 18:23, Marcel Holtmann <marcel@holtmann.org> wrote:
> > > This is an RFC of the proposed power sequencer subsystem. This is a
> > > generification of the MMC pwrseq code. The subsystem tries to abstract
> > > the idea of complex power-up/power-down/reset of the devices.
> > >
> > > The primary set of devices that promted me to create this patchset is
> > > the Qualcomm BT+WiFi family of chips. They reside on serial+platform
> > > interfaces (older generations) or on serial+PCIe (newer generations).
> > > They require a set of external voltage regulators to be powered on and
> > > (some of them) have separate WiFi and Bluetooth enable GPIOs.
> > >
> > > This patchset being an RFC tries to demonstrate the approach, design and
> > > usage of the pwrseq subsystem. Following issues are present in the RFC
> > > at this moment but will be fixed later if the overall approach would be
> > > viewed as acceptable:
> > >
> > > - No documentation
> > >   While the code tries to be self-documenting proper documentation
> > >   would be required.
> > >
> > > - Minimal device tree bindings changes
> > >   There are no proper updates for the DT bindings (thus neither Rob
> > >   Herring nor devicetree are included in the To/Cc lists). The dt
> > >   schema changes would be a part of v1.
> > >
> > > - Lack of proper PCIe integration
> > >   At this moment support for PCIe is hacked up to be able to test the
> > >   PCIe part of qca6390. Proper PCIe support would require automatically
> > >   powering up the devices before the scan basing on the proper device
> > >   structure in the device tree.
> > >
> > > ----------------------------------------------------------------
> > > Dmitry Baryshkov (15):
> > >      power: add power sequencer subsystem
> > >      pwrseq: port MMC's pwrseq drivers to new pwrseq subsystem
> > >      mmc: core: switch to new pwrseq subsystem
> > >      ath10k: add support for pwrseq sequencing
> > >      Bluetooth: hci_qca: merge qca_power into qca_serdev
> > >      Bluetooth: hci_qca: merge init paths
> > >      Bluetooth: hci_qca: merge qca_power_on with qca_regulators_init
> > >      Bluetooth: hci_qca: futher rework of power on/off handling
> > >      Bluetooth: hci_qca: add support for pwrseq
> >
> > any chance you can try to abandon patching hci_qca. The serdev support in hci_uart is rather hacking into old line discipline code and it is not aging well. It is really becoming a mess.
> 
> I wanted to stay away from rewriting the BT code. But... New driver
> would have a bonus point that I don't have to be compatible with old
> bindings.

It would be preferable if this was a implementation-only change and that
we kept the existing binding and existing dtb continued to work.

Regards,
Bjorn
