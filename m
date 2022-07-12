Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82B0571CE6
	for <lists+linux-mmc@lfdr.de>; Tue, 12 Jul 2022 16:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbiGLOil (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 12 Jul 2022 10:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiGLOik (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2022 10:38:40 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4FCCE3D
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 07:38:38 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id va17so14748001ejb.0
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 07:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gw1mMD/flbBthjeePLv0Y0kXpV5IbTidTrLktbLyhI0=;
        b=RqvbrWCcIXdea2f/Qj13QYE1BRKwtksUEdIM42qx/PVQpw3a3azwxxJP9qPZC08xRf
         8s8pqVZRBvGcJtI5eq/5QlsY7R7XvK1pHPqhBYFAIu5Y7yejJep+Q935ranUohVWDtmx
         HyMEocB1O/uNpk9Ng1ucXJybonOk76kz0yEBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gw1mMD/flbBthjeePLv0Y0kXpV5IbTidTrLktbLyhI0=;
        b=Q3hwUQPU4Q15Ou5vNTEcKQHDYC/cmKADnYGQ99XL6VId4yA+fXoV+YAFf2Y0D72n+y
         UnkGhZj38VKsaV8mcwE76FIa8I+qV4bY8hhPxtsBiXBFYuVKw+hQ9Kmpi0mq9TjjFfIM
         QtEhtDwIREEnlD5KI3MzvQ31H+lVnvJseoP7uzKXQYrfkIAkurHgN9OvqAoHLRII86ur
         OnXTX7ZgyIB4fPLRmz4MYmj4VHXsc/jIFq21rakcKx/ZqnrGxRfohfDFk/fLQwj6Rj5n
         SziQE/ajq6KStAbS1ABRDeSZqUzUpKgW8erNM0fvVovaSiv5FFoI8ywUulCn4M7e+4uR
         R2YQ==
X-Gm-Message-State: AJIora8py40jwArRjvrqz8mbkV66DRJnMRz8rpuIazl8a5oa5hal8m1M
        5x8dj1EQvKp/cDEwns2elDr7Pbyz8YbT+c3cObM=
X-Google-Smtp-Source: AGRyM1vpQv4Ua84dpHGReGxi0iYGL6VEFZEsrzdwGm9/e3nJNvh/252STGqcN7d+bg4PCae2KXKgGg==
X-Received: by 2002:a17:907:7e87:b0:72b:4af3:bf57 with SMTP id qb7-20020a1709077e8700b0072b4af3bf57mr13401902ejc.9.1657636717199;
        Tue, 12 Jul 2022 07:38:37 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id b4-20020a17090630c400b006fe0abb00f0sm3856344ejb.209.2022.07.12.07.38.36
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 07:38:37 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id r129-20020a1c4487000000b003a2d053adcbso6851059wma.4
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 07:38:36 -0700 (PDT)
X-Received: by 2002:a05:600c:511c:b0:3a2:d480:9390 with SMTP id
 o28-20020a05600c511c00b003a2d4809390mr4146899wms.93.1657636715865; Tue, 12
 Jul 2022 07:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220711082709.39102-1-krzysztof.kozlowski@linaro.org>
 <20220711082709.39102-2-krzysztof.kozlowski@linaro.org> <CAD=FV=W7BCMTByC9xn2iRsxoB9RzRENz5zuTy1Sgmhjbw3aQMw@mail.gmail.com>
 <6ebdb95a-6458-b77e-e14c-e89539c51b3f@linaro.org>
In-Reply-To: <6ebdb95a-6458-b77e-e14c-e89539c51b3f@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 12 Jul 2022 07:38:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WGxQF4vPuRi7kWKoqTpe0RFsgH+J82C=sQbmncK_AFpw@mail.gmail.com>
Message-ID: <CAD=FV=WGxQF4vPuRi7kWKoqTpe0RFsgH+J82C=sQbmncK_AFpw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: sdhci-msm: add MSM8998 SDCC specific compatible
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Mon, Jul 11, 2022 at 11:47 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 11/07/2022 17:08, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Jul 11, 2022 at 1:27 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> Add a MSM8998-specific SDCC compatible, because using only a generic
> >> qcom,sdhci-msm-v4 fallback is deprecated.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  drivers/mmc/host/sdhci-msm.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> >> index e395411fb6fd..bb169c1c2b5e 100644
> >> --- a/drivers/mmc/host/sdhci-msm.c
> >> +++ b/drivers/mmc/host/sdhci-msm.c
> >> @@ -2447,6 +2447,7 @@ static const struct of_device_id sdhci_msm_dt_match[] = {
> >>         {.compatible = "qcom,msm8992-sdhci", .data = &sdhci_msm_mci_var},
> >>         {.compatible = "qcom,msm8994-sdhci", .data = &sdhci_msm_mci_var},
> >>         {.compatible = "qcom,msm8996-sdhci", .data = &sdhci_msm_mci_var},
> >> +       {.compatible = "qcom,msm8998-sdhci", .data = &sdhci_msm_mci_var},
> >
> > FWIW I'm _against_ this change.
> >
> > In my mind while it is correct to specify both the specific and
> > generic compatible string in the device tree, the driver itself should
> > rely on just the generic compatible string until there is a reason to
> > use the specific one (like we needed to for sdm845 and sc7180).
> >
> > I think I pointed that out before, but somehow all of the specific
> > device tree strings have snuck their way into the driver without me
> > paying attention. :(
>
> I thought it's existing practice for some time, but it's a fresh commit
> 466614a9765c ("mmc: sdhci-msm: Add SoC specific compatibles"). I agree
> that it does not make much sense to add each compatible to the driver,
> so how about reverting 466614a9765c?

That would be my vote.

-Doug
