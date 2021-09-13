Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F584096BA
	for <lists+linux-mmc@lfdr.de>; Mon, 13 Sep 2021 17:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345824AbhIMPHx (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 13 Sep 2021 11:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345113AbhIMPHu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Sep 2021 11:07:50 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54C1C00874F
        for <linux-mmc@vger.kernel.org>; Mon, 13 Sep 2021 06:43:09 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g1so9758468lfj.12
        for <linux-mmc@vger.kernel.org>; Mon, 13 Sep 2021 06:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tQAMjy8VRvJI6lW4tYB0PDHpx0tw8jGULSmN/FaNG+g=;
        b=Bbb/S9bUWOBSsQ3pUMTVPvPM3mELyvG1d1Lp39NxhVgmVk+79l6sqgb6LzWCOb4L0G
         4xOUKFakiyAC6nrltsn+MB6bUBos4WlUB0nm7FHkp2RF21NdRLUEm4sunjTSdshoRv4K
         eNLAmdHSnHkdwraYqYyvKCPiIaApFzA0oCxB65b4ONd9T/nu22W+N71E6gYzBiva34CW
         IgswZYwE132B2XWdZPaLFJFxywQZsw2cZ4gmU7fM6bSCADjsWz2QqrQNXrytfyNxu0Ed
         QWM6q7ZowPchznXUFAyvgGnmTOZr9Qu57dB5+Rp0N50r+t46TxzQtEkrBzX3RfDkuaUN
         gsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tQAMjy8VRvJI6lW4tYB0PDHpx0tw8jGULSmN/FaNG+g=;
        b=i6LdHGAmxSIyxo9ODgJmdnihU6/qnkhswkruVadHXogW8OHYy1zUOrzyMN7kNHf17w
         FwJAs/JpGzAHa/ydISBdmX1nEdZcEX/D7Q7ynTaBY5k6OBS/SluFtDfS3MPrqI7VsZzD
         hvkohHHPL/kupG+p5KrNabxCRSB4ezDKfMQyrddagE+k/6LjWrV9XBS4E9HAZRCnJjQx
         /AQ+/fg/w8NZWovH8c1ayvKmbCJOEbYH/d5msMY8nkl2ZcEbMX1uJ0Vu7kDlxgHMS5rE
         f34tlYimw0WSiy4ym44gDZbSpwkpOskkzpEpn2JMgTNsY+9rnrb3m+s+kNQa5dZgF9DB
         9uHA==
X-Gm-Message-State: AOAM532vDM+/Y8HnhCE6VQ5ISFtIg6cqV+L1GslMqRR2fP2GNvfTsCy1
        iFKv+1MInpG1neOWBg/faG3PNh5HHg539M84ME14jA==
X-Google-Smtp-Source: ABdhPJy07GBvfOdosgOPOaGQzsGX2CjzdZ3iQjt2WHHbgd+CW+rDXGN21SD5O2GYnEG/e8C/opszahQX3cMDMdCSpjk=
X-Received: by 2002:a05:6512:6cd:: with SMTP id u13mr8847405lff.184.1631540588087;
 Mon, 13 Sep 2021 06:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210829131305.534417-1-dmitry.baryshkov@linaro.org>
 <20210829131305.534417-2-dmitry.baryshkov@linaro.org> <CAPDyKFp9CM+x505URK=hcO0QFqcZrpqzQ6uJQ=ZLR6uq-_d5Ew@mail.gmail.com>
 <a0f8766a-7810-0ca5-229a-a40f73041dd9@linaro.org>
In-Reply-To: <a0f8766a-7810-0ca5-229a-a40f73041dd9@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 13 Sep 2021 15:42:31 +0200
Message-ID: <CAPDyKFrfEQr0czXeNeJbKSfP0toKuowwOX7yb89c723BORRqCA@mail.gmail.com>
Subject: Re: [RFC v2 01/13] power: add power sequencer subsystem
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

[...]

> >> +
> >> +struct pwrseq *of_pwrseq_xlate_onecell(void *data, struct of_phandle_args *args)
> >> +{
> >> +       struct pwrseq_onecell_data *pwrseq_data = data;
> >> +       unsigned int idx;
> >> +
> >> +       if (args->args_count != 1)
> >> +               return ERR_PTR(-EINVAL);
> >> +
> >> +       idx = args->args[0];
> >> +       if (idx >= pwrseq_data->num) {
> >> +               pr_err("%s: invalid index %u\n", __func__, idx);
> >> +               return ERR_PTR(-EINVAL);
> >> +       }
> >
> > In many cases it's reasonable to leave room for future extensions, so
> > that a provider could serve with more than one power-sequencer. I
> > guess that is what you intend to do here, right?
> >
> > In my opinion, I don't think what would happen, especially since a
> > power-sequence is something that should be specific to one particular
> > device (a Qcom WiFi/Blutooth chip, for example).
> >
> > That said, I suggest limiting this to a 1:1 mapping between the device
> > node and power-sequencer. I think that should simplify the code a bit.
>
> In fact the WiFi/BT example itself provides a non 1:1 mapping. In my
> current design the power sequencer provides two instances (one for WiFi,
> one for BT). This allows us to move the knowledge about "enable" pins to
> the pwrseq. Once the QCA BT driver acquires and powers up the pwrseq,
> the BT part is ready. No need to toggle any additional pins. Once the
> WiFi pwrseq is powered up, the WiFi part is present on the bus and
> ready, without any additional pin toggling.

Aha, that seems reasonable.

>
> I can move onecell support to the separate patch if you think this might
> simplify the code review.

It doesn't matter, both options work for me.

[...]

Kind regards
Uffe
