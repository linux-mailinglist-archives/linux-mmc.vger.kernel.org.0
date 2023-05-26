Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3031571273F
	for <lists+linux-mmc@lfdr.de>; Fri, 26 May 2023 15:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237320AbjEZNMD (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 26 May 2023 09:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236409AbjEZNMC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 26 May 2023 09:12:02 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E94913A
        for <linux-mmc@vger.kernel.org>; Fri, 26 May 2023 06:12:01 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-565014fc2faso11769487b3.1
        for <linux-mmc@vger.kernel.org>; Fri, 26 May 2023 06:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685106720; x=1687698720;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ehmbo/9JYt1lCkVSL99oekFqIjUFbJATCkffp/yKxk=;
        b=e6O1GH/hxnOBXiLdaGwz5N5cGwjwp61mv1HGy5CSpAunWdYfkVclEiQyxp7TumIBcQ
         xggHt1obtjJy08WmY646kjNIQHz4/51ceoOC8QBOdwHSSqMcRpe5rmMhLyuq5+abjORG
         7QssuDIzcGXs8cpzdT3gQ7x2IoR4yhXZ31y3mehaLP6hfcCiqT41wDKgU7wyews1SBZL
         jg9TzaObWhhRWSJB/vzQ/UBMSzeiVU79QheKw0Fi3hit7GIygGqpdp9FO4FQbIG6SDDP
         kXM5UnBIVuB/cT9APKwV0c4F7Z/MBRxpZR7leQV//sH4Vfz32/pIxuaxQNS5Qpp7hfgW
         HlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685106720; x=1687698720;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Ehmbo/9JYt1lCkVSL99oekFqIjUFbJATCkffp/yKxk=;
        b=Tgy4ARrj/iYsp1W4+H7d72FDuq5E7g4FJ6lhfKBv+OGrrmi2hCWCG8Z7gxONvdNlVx
         aOtvEl1e5kSnGaeJwIHJZi1NvOcQ6VR3K7w+GN7nact8cYK+u/wGDpNWd3tqcyQciOJH
         sIJ+W/zcmzqNlVInTSA45nJ8h0NeeBuHI5nF6xDi2TBDQqsTweR1ofoYodrM1u01pbOl
         rWX9pl9PBdcvgPP2pCChysgAFFu4Ot5grKPGW6zGiEnS1wUHnr7aiZKIn2s7uEN5ivWT
         XlgdbcNNFxkytvQcUI6xk24Stz2i+CvJYQnnAe6xwPvOundmEB2CubL1ezFgK9k2L2Gr
         8uVw==
X-Gm-Message-State: AC+VfDzo0EokLw+gOsvR/+HL70yLNj3ObvHoAydx/6iR18ag9Fa+etzT
        HGIXZLqxVdOu7MNZdPRLWBLLHcvoaMd4mSGpp3mj5g==
X-Google-Smtp-Source: ACHHUZ6/7ewhUAPiWsrzVpC/fUD5WOgoEQkursSgI+mXOtDf6jZmessh1NGgYkDGVt/NijBbKX86v1AG3oL6WXAcDGM=
X-Received: by 2002:a81:5290:0:b0:561:d21d:8ce3 with SMTP id
 g138-20020a815290000000b00561d21d8ce3mr2470807ywb.3.1685106720443; Fri, 26
 May 2023 06:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230522202425.1827005-2-martin.blumenstingl@googlemail.com> <168503099830.22756.1444846830853755949.kvalo@kernel.org>
In-Reply-To: <168503099830.22756.1444846830853755949.kvalo@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 26 May 2023 15:11:24 +0200
Message-ID: <CAPDyKFr5X+rhx=0mUiy_w0Aik9re5WD71xn-H_hrbTDR1L08ww@mail.gmail.com>
Subject: Re: [PATCH wireless-next v2 1/4] wifi: rtw88: sdio: Check the HISR
 RX_REQUEST bit in rtw_sdio_rx_isr()
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony0620emma@gmail.com,
        Peter Robinson <pbrobinson@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>, jernej.skrabec@gmail.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 25 May 2023 at 18:10, Kalle Valo <kvalo@kernel.org> wrote:
>
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>
> > rtw_sdio_rx_isr() is responsible for receiving data from the wifi chip
> > and is called from the SDIO interrupt handler when the interrupt status
> > register (HISR) has the RX_REQUEST bit set. After the first batch of
> > data has been processed by the driver the wifi chip may have more data
> > ready to be read, which is managed by a loop in rtw_sdio_rx_isr().
> >
> > It turns out that there are cases where the RX buffer length (from the
> > REG_SDIO_RX0_REQ_LEN register) does not match the data we receive. The
> > following two cases were observed with a RTL8723DS card:
> > - RX length is smaller than the total packet length including overhead
> >   and actual data bytes (whose length is part of the buffer we read from
> >   the wifi chip and is stored in rtw_rx_pkt_stat.pkt_len). This can
> >   result in errors like:
> >     skbuff: skb_over_panic: text:ffff8000011924ac len:3341 put:3341
> >   (one case observed was: RX buffer length = 1536 bytes but
> >    rtw_rx_pkt_stat.pkt_len = 1546 bytes, this is not valid as it means
> >    we need to read beyond the end of the buffer)
> > - RX length looks valid but rtw_rx_pkt_stat.pkt_len is zero
> >
> > Check if the RX_REQUEST is set in the HISR register for each iteration
> > inside rtw_sdio_rx_isr(). This mimics what the RTL8723DS vendor driver
> > does and makes the driver only read more data if the RX_REQUEST bit is
> > set (which seems to be a way for the card's hardware or firmware to
> > tell the host that data is ready to be processed).
> >
> > For RTW_WCPU_11AC chips this check is not needed. The RTL8822BS vendor
> > driver for example states that this check is unnecessary (but still uses
> > it) and the RTL8822CS drops this check entirely.
> >
> > Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> 4 patches applied to wireless-next.git, thanks.
>
> e967229ead0e wifi: rtw88: sdio: Check the HISR RX_REQUEST bit in rtw_sdio_rx_isr()
> 9be20a822327 wifi: rtw88: rtw8723d: Implement RTL8723DS (SDIO) efuse parsing
> 09fcdbd28404 mmc: sdio: Add/rename SDIO ID of the RTL8723DS SDIO wifi cards
> a3b125ceb45e wifi: rtw88: Add support for the SDIO based RTL8723DS chipset

If it's not too late, feel free to add my ack for patch3. Nevermind,
if it adds additional work for you.

Kind regards
Uffe
