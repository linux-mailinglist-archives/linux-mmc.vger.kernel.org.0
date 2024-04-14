Return-Path: <linux-mmc+bounces-1811-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF0C8A43A3
	for <lists+linux-mmc@lfdr.de>; Sun, 14 Apr 2024 17:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCB6DB21847
	for <lists+linux-mmc@lfdr.de>; Sun, 14 Apr 2024 15:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84969134CCC;
	Sun, 14 Apr 2024 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U82B873z"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E5B134CC0
	for <linux-mmc@vger.kernel.org>; Sun, 14 Apr 2024 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713110152; cv=none; b=ohFGuFd2Sowr82+UDmZW3dgJLAPxTaKrzYciOSoxjTxn2Xt4mEAdm89zT8OHzocKor1VVN9WwqefsVkbqjbjilcCq0EvwK+t6x+mPiRGIHgIztiy59ltVX/qAv9l8psmuGdEFsGmKYAQzvZGuEerX7vn4Sn1oWzZREx4YgjPsg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713110152; c=relaxed/simple;
	bh=I3PvpLg5Y4F+c/P3rCNY0SXl1/TCLrhqef4r8MOkJWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hRrNPDELRO1CKVeMi1EwUS7RgPxKvVwP2RFFyPde6ySWDu0RQynfPSeZkBGoSqq09oGvjR4rIDiaiJZ9doPXhhj0UKEfkbUK8nVIuwHtvgw4utGvpNXpZ7enADvxkN4u8VL9IUGLRrmuhSPfoVfv30dym/2Shq3RyVl+9WpJar0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U82B873z; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e3cf5b171eso19439225ad.0
        for <linux-mmc@vger.kernel.org>; Sun, 14 Apr 2024 08:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1713110150; x=1713714950; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wA9a7w64oa510Mt0Avlwa94Gm/wXev1e21s45jcaVo0=;
        b=U82B873zMkzaF83eZP2CM53SIb846ur6AdBKw1wvGpSngVCitX5ORMX/4n6gCuFEl4
         q7R3UpWG439Q1uG7/vUFcymR6Yh7MbQLqDtiiHU/6SNkOTphHm9iFjW/Kf2V2J2MQ85W
         LyC5fJRm0DJZPrBIEFRLEY73HGwHMonOG9/UE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713110150; x=1713714950;
        h=in-reply-to:autocrypt:from:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wA9a7w64oa510Mt0Avlwa94Gm/wXev1e21s45jcaVo0=;
        b=SahfrfVDmIxU9Qu2yigGeJoEnP1hktdALADHHbSGgB56S7kd2pWIFS5e3U0s7BcMZK
         QxvDHsyQnWhaelI8Q6nenBjD1MbBDX3K0Rfq61YRQWKqYSEWEdcO/17EISWqalqFW3F5
         5PR2slZ620I8L/+T7lJdsuaOpm/B0tUcq/x0qkGkbs4KZKJLKVVIjOL6AJrhLlUGd8vQ
         +a+aB+a0DBxsREo6MMMP8XoskSopXH+0da9wF1qb5sjxZNL5OlHXytjNlc4pDE0fugwF
         SPJUvPEFXgH0EvyBSSqukXlJUX5g07Bvi8Yk6waZE5ZsA4RHYuDJEpSr9Xshpy2K91oY
         xCXg==
X-Forwarded-Encrypted: i=1; AJvYcCX7i3xE7VUocr1ItekSiZfxAQF43YIdoVX+Hv4SGT91wD+71uEWbqKSo+XEOOZsTil5Zn9bCXF+jtXv/+ZX+K81qdrpBGtcXkfx
X-Gm-Message-State: AOJu0Yw2Job9OUrrq/r6mhpnp+AngxZommczuMzgzmx/HILkzgKkHgnF
	vEl/puqX1ZGWSoNYsZlQ+Y8p8rFK2cCtIFYwSJI7WrMt1gt5jjQEIbBmEgctpw==
X-Google-Smtp-Source: AGHT+IEpghY1/UN6oixfrvY+JfUujcYCx1D8h4CO1+rPH2DvavzruMHxGyQg6lVLmuuj/W3agKXSrQ==
X-Received: by 2002:a17:902:cece:b0:1e4:2d13:cf68 with SMTP id d14-20020a170902cece00b001e42d13cf68mr9428877plg.17.1713110150126;
        Sun, 14 Apr 2024 08:55:50 -0700 (PDT)
Received: from [10.230.29.214] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j5-20020a170903024500b001e120a9e964sm6133138plh.126.2024.04.14.08.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Apr 2024 08:55:49 -0700 (PDT)
Message-ID: <6042c0c7-bb8a-4898-8bed-92155b8e9c4f@broadcom.com>
Date: Sun, 14 Apr 2024 08:55:45 -0700
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] mmc: sdhci-brcmstb: Add BCM2712 SD Express support
To: Andrea della Porta <andrea.porta@suse.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Kamal Dasu
 <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, Jonathan Bell <jonathan@raspberrypi.com>,
 Phil Elwell <phil@raspberrypi.com>
References: <cover.1713036964.git.andrea.porta@suse.com>
 <a3d82e5a28fe53f1f61621d37d1695b0cd7655d2.1713036964.git.andrea.porta@suse.com>
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <a3d82e5a28fe53f1f61621d37d1695b0cd7655d2.1713036964.git.andrea.porta@suse.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000fc6acf0616108930"

--000000000000fc6acf0616108930
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/13/2024 3:14 PM, Andrea della Porta wrote:
> Broadcom BCM2712 SDHCI controller is SD Express capable. Add support
> for sde capability where the implementation is based on downstream driver,
> diverging from it in the way that init_sd_express callback is invoked:
> in downstream the sdhci_ops structure has been augmented with a new
> function ptr 'init_sd_express' that just propagate the call to the
> driver specific callback so that the callstack from a structure
> standpoint is mmc_host_ops -> sdhci_ops. The drawback here is in the
> added level of indirection (the newly added init_sd_express is
> redundant) and the sdhci_ops structure declaration has to be changed.
> To overcome this the presented approach consist in patching the mmc_host_ops
> init_sd_express callback to point directly to the custom function defined in
> this driver (see struct brcmstb_match_priv).
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>   drivers/mmc/host/Kconfig         |   1 +
>   drivers/mmc/host/sdhci-brcmstb.c | 147 ++++++++++++++++++++++++++++++-
>   2 files changed, 147 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index aebc587f77a7..343ccac1a4e4 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1018,6 +1018,7 @@ config MMC_SDHCI_BRCMSTB
>   	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
>   	depends on MMC_SDHCI_PLTFM
>   	select MMC_CQHCI
> +	select OF_DYNAMIC
>   	default ARCH_BRCMSTB || BMIPS_GENERIC
>   	help
>   	  This selects support for the SDIO/SD/MMC Host Controller on
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index 907a4947abe5..56fb34a75ec2 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -29,6 +29,7 @@
>   
>   #define BRCMSTB_PRIV_FLAGS_HAS_CQE		BIT(0)
>   #define BRCMSTB_PRIV_FLAGS_GATE_CLOCK		BIT(1)
> +#define BRCMSTB_PRIV_FLAGS_HAS_SD_EXPRESS	BIT(2)
>   
>   #define SDHCI_ARASAN_CQE_BASE_ADDR		0x200
>   
> @@ -50,13 +51,19 @@ struct sdhci_brcmstb_priv {
>   	unsigned int flags;
>   	struct clk *base_clk;
>   	u32 base_freq_hz;
> +	struct regulator *sde_1v8;
> +	struct device_node *sde_pcie;
> +	void *__iomem sde_ioaddr;
> +	void *__iomem sde_ioaddr2;
>   	struct pinctrl *pinctrl;
>   	struct pinctrl_state *pins_default;
> +	struct pinctrl_state *pins_sdex;
>   };
>   
>   struct brcmstb_match_priv {
>   	void (*hs400es)(struct mmc_host *mmc, struct mmc_ios *ios);
>   	void (*cfginit)(struct sdhci_host *host);
> +	int (*init_sd_express)(struct mmc_host *mmc, struct mmc_ios *ios);
>   	struct sdhci_ops *ops;
>   	const unsigned int flags;
>   };
> @@ -263,6 +270,105 @@ static void sdhci_brcmstb_cfginit_2712(struct sdhci_host *host)
>   	}
>   }
>   
> +static int bcm2712_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_brcmstb_priv *brcmstb_priv = sdhci_pltfm_priv(pltfm_host);
> +	struct device *dev = host->mmc->parent;
> +	u32 ctrl_val;
> +	u32 present_state;
> +	int ret;
> +
> +	if (!brcmstb_priv->sde_ioaddr || !brcmstb_priv->sde_ioaddr2)
> +		return -EINVAL;
> +
> +	if (!brcmstb_priv->pinctrl)
> +		return -EINVAL;
> +
> +	/* Turn off the SD clock first */
> +	sdhci_set_clock(host, 0);
> +
> +	/* Disable SD DAT0-3 pulls */
> +	pinctrl_select_state(brcmstb_priv->pinctrl, brcmstb_priv->pins_sdex);
> +
> +	ctrl_val = readl(brcmstb_priv->sde_ioaddr);
> +	dev_dbg(dev, "ctrl_val 1 %08x\n", ctrl_val);
> +
> +	/* Tri-state the SD pins */
> +	ctrl_val |= 0x1ff8;

No magic values please.

> +	writel(ctrl_val, brcmstb_priv->sde_ioaddr);
> +	dev_dbg(dev, "ctrl_val 1->%08x (%08x)\n", ctrl_val, readl(brcmstb_priv->sde_ioaddr));
> +	/* Let voltages settle */
> +	udelay(100);

Why not usleep_range()?

> +
> +	/* Enable the PCIe sideband pins */
> +	ctrl_val &= ~0x6000;

No magic values please.

> +	writel(ctrl_val, brcmstb_priv->sde_ioaddr);
> +	dev_dbg(dev, "ctrl_val 1->%08x (%08x)\n", ctrl_val, readl(brcmstb_priv->sde_ioaddr));
> +	/* Let voltages settle */
> +	udelay(100);

Likewise.

> +
> +	/* Turn on the 1v8 VDD2 regulator */
> +	ret = regulator_enable(brcmstb_priv->sde_1v8);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait for Tpvcrl */
> +	msleep(1);
> +
> +	/* Sample DAT2 (CLKREQ#) - if low, card is in PCIe mode */
> +	present_state = sdhci_readl(host, SDHCI_PRESENT_STATE);
> +	present_state = (present_state & SDHCI_DATA_LVL_MASK) >> SDHCI_DATA_LVL_SHIFT;
> +	dev_dbg(dev, "state = 0x%08x\n", present_state);
> +
> +	if (present_state & BIT(2)) {

Likewise, replace with constant.

> +		dev_err(dev, "DAT2 still high, abandoning SDex switch\n");
> +		return -ENODEV;
> +	}
> +
> +	/* Turn on the LCPLL PTEST mux */
> +	ctrl_val = readl(brcmstb_priv->sde_ioaddr2 + 20); // misc5
> +	ctrl_val &= ~(0x7 << 7);
> +	ctrl_val |= 3 << 7;
> +	writel(ctrl_val, brcmstb_priv->sde_ioaddr2 + 20);
> +	dev_dbg(dev, "misc 5->%08x (%08x)\n", ctrl_val, readl(brcmstb_priv->sde_ioaddr2 + 20));
> +
> +	/* PTEST diff driver enable */
> +	ctrl_val = readl(brcmstb_priv->sde_ioaddr2);
> +	ctrl_val |= BIT(21);
> +	writel(ctrl_val, brcmstb_priv->sde_ioaddr2);
> +
> +	dev_dbg(dev, "misc 0->%08x (%08x)\n", ctrl_val, readl(brcmstb_priv->sde_ioaddr2));
> +
> +	/* Wait for more than the minimum Tpvpgl time */
> +	msleep(100);
> +
> +	if (brcmstb_priv->sde_pcie) {
> +		struct of_changeset changeset;
> +		static struct property okay_property = {
> +			.name = "status",
> +			.value = "okay",
> +			.length = 5,
> +		};
> +
> +		/* Enable the pcie controller */
> +		of_changeset_init(&changeset);
> +		ret = of_changeset_update_property(&changeset,
> +						   brcmstb_priv->sde_pcie,
> +						   &okay_property);
> +		if (ret) {
> +			dev_err(dev, "%s: failed to update property - %d\n", __func__,
> +			       ret);
> +			return -ENODEV;
> +		}
> +		ret = of_changeset_apply(&changeset);
> +	}

Why are you doing this? Cannot the firmware enable/disable the node 
according to the boot mode or something else?

This is not going to fly for upstream, sorry.
-- 
Florian

--000000000000fc6acf0616108930
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIL7mQ7DAviqxfwYI
OnO264yS0BxtP2rvdeti/Go+SM/9MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTI0MDQxNDE1NTU1MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBd6Inv4SgeIoIXbGfRWgdJpjcAREIqen49
Ej7BkZlQsHWE5uYlO0Zq8z6TncumWm61qveS9gOA46c48B6/VynqLJiEROIFG2mSzk0gSqgMNizn
YmX0szF3ONHy7lKNFespPgVvM4gPsffQHXKHt7J0w8XdZM5CRZPgdbo84Xxvxbg42+M8/2DBiuft
FssH6Ev96QVUrbksic+h7aHWy1y038JGzGKsLN9Kyy1+qE+DBSnV+gwPkZCkEGEmTSaEssp28J4E
mn6tsaEJRpwHCWRWeYdI8kEplbIB3LJWAgxdjHfR8310TI7KdwJjvZgiKQt01qKn9Y/3uNCG6p2j
S090
--000000000000fc6acf0616108930--

