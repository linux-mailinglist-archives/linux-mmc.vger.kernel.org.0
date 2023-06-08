Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1DE728B3E
	for <lists+linux-mmc@lfdr.de>; Fri,  9 Jun 2023 00:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjFHWub (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 8 Jun 2023 18:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236392AbjFHWua (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2023 18:50:30 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDEB2D59
        for <linux-mmc@vger.kernel.org>; Thu,  8 Jun 2023 15:50:28 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-bacf5b89da7so1221386276.2
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jun 2023 15:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686264628; x=1688856628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4RuUAGdF6ksVWX/V1p878VKkq1mr3gQQSAdPGDm1wSU=;
        b=E2n3QmygG6mBTFtq+c60GKW16BROIMRCLSvvZzyB5McQYIkFBaLl9s8uTOv0pA1sh5
         lP0drdMNDgAf85uw/cF+r5BJ8WaZ2Zc3bK//QWXpIqPAUC50tK93s/3YLbjEnSX6bKNb
         0AwERGiuAf1HEwA95T5CpKJOdaoiotfBuaADlXKwtVwz2M7V4umGZEvmUB/Xb+8Ti3Oe
         ZJy0pEa+4vZoL9BfArmZjkzAGIkZx1zqMLIpz5Iwl5w90GVvefvd7E72kL5Jnad02q5U
         Zpdbc8vj5HEiPZvOvUgG8iEupb3mu57u6CGq3DyJ/D1xFIJjtRGM3h7A2p3WLpa+z+3X
         Y2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686264628; x=1688856628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RuUAGdF6ksVWX/V1p878VKkq1mr3gQQSAdPGDm1wSU=;
        b=BgVKR4IrJx9xDzI3ZjDUS3P77s4yqIEkoekS2Ya4H0hbeGOxGyVum7oeJ0bjGr7t0z
         zPKA/cg+mAxKshbvfKBzYoMFzkhORkILm3FSVlfCPplJ/CRhic45YChH+R5A5OoITNmV
         rYdLl2eouj5hj848t9wi19iqg5z75I3s34QH+gvj3TcrLP4OBrEXiIgmqM12ZW9SEIPO
         pikZawpq3bp8elIlrWcTeSc6d5t4T6Oztu33NuzZlbifHkzlXnxD6rKk/JtMeodeXBQ0
         4bpZJmBP4ulVPx6cAh0QVljEaCQXlkkf2AinW9+/1Zp4LFdPffEeT1t4U/JS2jzX2dov
         GOeg==
X-Gm-Message-State: AC+VfDxDAAg/ouSubh9TxMy1FP11bxjj8/fFnGYMl+iWsZhN71o6oiWX
        BRl3KBmPy/aipCp242Oa6jxeP07kyCWNTccplPchqA==
X-Google-Smtp-Source: ACHHUZ6pF/H4zsRBhkifFg0zXH9TRdDQIQXq+QZWXbz7vfwfrSKKgaM/PnGph0j8F23dJSnuz/FV21fKIcAA0PdiHeY=
X-Received: by 2002:a0d:f6c4:0:b0:55a:40d3:4d6f with SMTP id
 g187-20020a0df6c4000000b0055a40d34d6fmr855851ywf.26.1686264628032; Thu, 08
 Jun 2023 15:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230601015115.406002-1-victorshihgli@gmail.com> <20230601015115.406002-5-victorshihgli@gmail.com>
In-Reply-To: <20230601015115.406002-5-victorshihgli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 9 Jun 2023 00:49:52 +0200
Message-ID: <CAPDyKFre9qchf5Nu1N0LSZE2if+R7HXR=WfaPugCdQwwMvcTig@mail.gmail.com>
Subject: Re: [PATCH V5 4/4] mmc: sdhci-pci-gli: Add support SD Express card
 for GL9767
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

[...]

> +static int gl9767_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       struct sdhci_pci_slot *slot = sdhci_priv(host);
> +       struct pci_dev *pdev;
> +       u32 value;
> +       int i;
> +
> +       pdev = slot->chip->pdev;
> +
> +       if (mmc->ops->get_ro(mmc)) {
> +               mmc->ios.timing &= ~(MMC_TIMING_SD_EXP | MMC_TIMING_SD_EXP_1_2V);
> +               return 0;
> +       }
> +
> +       gl9767_vhs_write(pdev);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_COMBO_MUX_CTL, &value);
> +       value &= ~(PCIE_GLI_9767_COMBO_MUX_CTL_RST_EN | PCIE_GLI_9767_COMBO_MUX_CTL_WAIT_PERST_EN);
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_COMBO_MUX_CTL, value);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, &value);
> +       value &= ~PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME;
> +       value |= FIELD_PREP(PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME,
> +                           PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME_VALUE);
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, value);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2, &value);
> +       value |= PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_COMPLETE;
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2, value);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2, &value);
> +       value |= PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2_SDEI_COMPLETE_STATUS_EN;
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2, value);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2, &value);
> +       value |= PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2_SDEI_COMPLETE_SIGNAL_EN;
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2, value);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
> +       value |= PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
> +
> +       value = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +       value &= ~(SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_PLL_EN);
> +       sdhci_writew(host, value, SDHCI_CLOCK_CONTROL);
> +
> +       value = sdhci_readb(host, SDHCI_POWER_CONTROL);
> +       value |= (SDHCI_VDD2_POWER_180 | SDHCI_VDD2_POWER_ON);
> +       sdhci_writeb(host, value, SDHCI_POWER_CONTROL);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, &value);
> +       value |= PCIE_GLI_9767_SD_EXPRESS_CTL_SDEI_EXE;
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, value);
> +
> +       for (i = 0; i < 2; i++) {
> +               msleep(10);

Please convert to usleep_range().

[...]

Kind regards
Uffe
